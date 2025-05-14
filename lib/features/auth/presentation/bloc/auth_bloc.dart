import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tournament_app/features/auth/domain/use_cases/login_use_cases.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;

  AuthBloc({required this.loginUseCase}) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await loginUseCase.call(
      alias: event.alias,
      password: event.password,
    );

    result.fold(
      (failure) => emit(AuthFailure(failure.message ?? 'Error')),
      (user) => emit(AuthSuccess(user)),
    );
  }

  void _onLogoutRequested(LogoutRequested event, Emitter<AuthState> emit) {
    emit(AuthInitial());
  }
}
