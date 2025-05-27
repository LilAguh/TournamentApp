import 'package:flutter_bloc/flutter_bloc.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterState.initial()) {
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

    on<RegisterSubmitted>(_onRegisterSubmitted);
  }

  Future<void> _onRegisterSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    if (state.password != state.passwordRepeat) {
      emit(state.copyWith(errorMessage: 'Las contraseñas no coinciden'));
      return;
    }

    emit(state.copyWith(isLoading: true, errorMessage: null));

    // TODO: Agregar llamada al use case / repositorio
    await Future.delayed(const Duration(seconds: 2));

    // Simulación de éxito
    emit(state.copyWith(isLoading: false, isSuccess: true));
  }
}
