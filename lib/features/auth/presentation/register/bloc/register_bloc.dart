import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tournament_app/features/auth/domain/use_cases/register_use_cases.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterBloc({required this.registerUseCase})
    : super(RegisterState.initial()) {
    on<RegisterFirstNameChanged>(
      (event, emit) => emit(state.copyWith(firstName: event.firstName)),
    );

    on<RegisterLastNameChanged>(
      (event, emit) => emit(state.copyWith(lastName: event.lastName)),
    );

    on<RegisterAliasChanged>(
      (event, emit) => emit(state.copyWith(alias: event.alias)),
    );

    on<RegisterEmailChanged>(
      (event, emit) => emit(state.copyWith(email: event.email)),
    );

    on<RegisterPasswordChanged>(
      (event, emit) => emit(state.copyWith(password: event.password)),
    );

    on<RegisterPasswordRepeatChanged>(
      (event, emit) =>
          emit(state.copyWith(passwordRepeat: event.passwordRepeat)),
    );

    on<RegisterSubmitted>((event, emit) async {
      print('[RegisterBloc] Enviando datos al usecase...');

      if (state.password != state.passwordRepeat) {
        emit(state.copyWith(errorMessage: 'Las contraseñas no coinciden'));
        return;
      }

      emit(state.copyWith(isLoading: true, errorMessage: null));

      final prefs = await SharedPreferences.getInstance();
      final country = prefs.getString('user_country_code') ?? 'BR';

      final result = await registerUseCase.call(
        firstName: state.firstName,
        lastName: state.lastName,
        alias: state.alias,
        email: state.email,
        password: state.password,
        countryCode: country,
      );

      result.fold(
        (failure) {
          print('[RegisterBloc] Error: ${failure.message}');
          emit(state.copyWith(isLoading: false, errorMessage: failure.message));
        },
        (user) {
          print('[RegisterBloc] Usuario registrado con éxito');
          emit(state.copyWith(isLoading: false, isSuccess: true));
        },
      );
    });
  }
}
