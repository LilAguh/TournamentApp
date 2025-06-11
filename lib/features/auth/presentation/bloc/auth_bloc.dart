import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tournament_app/features/auth/config/auth_config.dart';
import 'package:tournament_app/features/auth/domain/use_cases/login_use_cases.dart';
import 'package:tournament_app/features/profile/domain/use_cases/get_profile_use_case.dart';
import 'auth_event.dart';
import 'auth_state.dart';

// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final LoginUseCase loginUseCase;

//   AuthBloc({required this.loginUseCase}) : super(AuthInitial()) {
//     on<LoginRequested>(_onLoginRequested);
//     on<LogoutRequested>(_onLogoutRequested);
//   }

//   Future<void> _onLoginRequested(
//     LoginRequested event,
//     Emitter<AuthState> emit,
//   ) async {
//     emit(AuthLoading());

//     final result = await loginUseCase.call(
//       alias: event.alias,
//       password: event.password,
//     );

//     result.fold(
//       (failure) => emit(AuthFailure(failure.message ?? 'Error')),
//       (user) => emit(AuthSuccess(user)),
//     );
//   }

//   void _onLogoutRequested(LogoutRequested event, Emitter<AuthState> emit) {
//     emit(AuthInitial());
//   }
// }

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;

  AuthBloc({required this.loginUseCase}) : super(AuthState.initial()) {
    on<AuthAliasChanged>((event, emit) {
      emit(state.copyWith(alias: event.alias));
    });
    on<AuthPasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });

    on<AuthLogoutRequested>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      emit(AuthState.initial()); // ✅ incluye alias/password vacíos

      print('[AUTH] Logout completado, sesión reiniciada.');
    });

    on<AuthSubmitted>((event, emit) async {
      if (state.alias.isEmpty || state.password.isEmpty) {
        emit(state.copyWith(errorMessage: 'Alias y contraseña son requeridos'));
        return;
      }

      emit(
        state.copyWith(isLoading: true, errorMessage: null, isSucess: false),
      );

      final result = await loginUseCase.call(
        alias: state.alias,
        password: state.password,
      );

      await result.fold(
        (failure) async {
          emit(
            state.copyWith(
              isLoading: false,
              errorMessage: failure.message,
              isSucess: false,
            ),
          );
        },
        (user) async {
          final prefs = await SharedPreferences.getInstance();

          // ✅ Guardar ID si aún no lo hacías acá (por seguridad)
          await prefs.setInt('userId', user.id);
          final token = prefs.getString('authToken') ?? '';

          print('[LOGIN] Usuario logueado:');
          print('ID: ${user.id}');
          print('Alias: ${user.alias}');
          print('Email: ${user.email}');
          print('Role: ${user.role}');

          // 🔥 GetProfile automático
          final profileResult = await sl<GetProfileUseCase>().call(
            userId: user.id,
            token: token,
          );

          profileResult.fold(
            (failure) {
              print('[PROFILE] Error al obtener perfil: ${failure.message}');
            },
            (profile) async {
              print('[PROFILE] Datos obtenidos:');
              print('Alias: ${profile.alias}');
              print('Email: ${profile.email}');
              print('Avatar: ${profile.avatarUrl}');

              // Guardar en prefs
              final prefs = await SharedPreferences.getInstance();

              await prefs.setString('profile_email', profile.email);
              await prefs.setString('profile_alias', profile.alias);
              await prefs.setString(
                'profile_passwordHash',
                profile.passwordHash,
              );
              await prefs.setString('profile_countryCode', profile.countryCode);
              await prefs.setString('profile_avatarUrl', profile.avatarUrl);
              await prefs.setString('profile_createdAt', profile.createdAt);
              if (profile.lastLogin != null) {
                await prefs.setString('profile_lastLogin', profile.lastLogin!);
              }

              await prefs.setBool('profile_isActive', profile.isActive);

              print('[PROFILE] Guardado en SharedPreferences');
            },
          );

          emit(
            state.copyWith(
              isLoading: false,
              isSucess: true,
              errorMessage: null,
            ),
          );
        },
      );
    });
  }
}
