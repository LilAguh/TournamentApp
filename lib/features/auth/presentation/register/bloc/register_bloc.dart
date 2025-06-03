import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tournament_app/features/auth/domain/use_cases/register_use_cases.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterBloc({required this.registerUseCase})
    : super(RegisterState.initial()) {
    on<RegisterFirstNameChanged>(_onFirstNameChanged);
    on<RegisterLastNameChanged>(_onLastNameChanged);
    on<RegisterAliasChanged>(_onAliasChanged);
    on<RegisterEmailChanged>(_onEmailChanged);
    on<RegisterPasswordChanged>(_onPasswordChanged);
    on<RegisterPasswordRepeatChanged>(_onPasswordRepeatChanged);
    on<RegisterSubmitted>(_onSubmitted);
  }

  // Validación de email
  bool _isValidEmail(String email) {
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      return false;
    }

    final domain = email.split('@').last;

    const commonDomains = [
      'gmail.com', 'yahoo.com', 'hotmail.com', 'outlook.com',
      'icloud.com', 'protonmail.com', 'aol.com', 'mail.com',
      'zoho.com',
      'yandex.com',
      'gmx.com',
      'example.com', // Agrega otros según necesidad
    ];

    if (commonDomains.contains(domain.toLowerCase())) {
      return true;
    }

    // Validación estricta para dominios personalizados
    return RegExp(
      r'^[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*\.[a-zA-Z]{2,}$',
    ).hasMatch(domain);
  }

  // Validación de contraseña (mínimo 8 chars, 1 mayúscula, 1 número y 1 carácter especial)
  bool _isValidPassword(String password) {
    return password.length >= 8 &&
        RegExp(r'[A-Z]').hasMatch(password) &&
        RegExp(r'[0-9]').hasMatch(password) &&
        RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);
  }

  // Manejo de cambios en cada campo
  void _onFirstNameChanged(
    RegisterFirstNameChanged event,
    Emitter<RegisterState> emit,
  ) {
    emit(
      state.copyWith(
        firstName: event.firstName,
        firstNameError: event.firstName.isEmpty ? 'Nombre requerido' : null,
      ),
    );
  }

  void _onLastNameChanged(
    RegisterLastNameChanged event,
    Emitter<RegisterState> emit,
  ) {
    emit(
      state.copyWith(
        lastName: event.lastName,
        lastNameError: event.lastName.isEmpty ? 'Apellido requerido' : null,
      ),
    );
  }

  void _onAliasChanged(
    RegisterAliasChanged event,
    Emitter<RegisterState> emit,
  ) {
    emit(
      state.copyWith(
        alias: event.alias,
        aliasError: event.alias.isEmpty ? 'Alias requerido' : null,
      ),
    );
  }

  void _onEmailChanged(
    RegisterEmailChanged event,
    Emitter<RegisterState> emit,
  ) {
    final isValid = event.email.isNotEmpty && _isValidEmail(event.email);
    final emailError =
        isValid
            ? null
            : event.email.isEmpty
            ? 'Email requerido'
            : 'Ingrese un email válido';

    // Crear un nuevo conjunto basado en el estado actual
    final newValidatedFields = Set<String>.from(state.validatedFields);

    if (isValid) {
      newValidatedFields.add('email');
    } else {
      newValidatedFields.remove('email');
    }

    emit(
      state.copyWith(
        email: event.email,
        emailError: emailError,
        validatedFields: newValidatedFields,
      ),
    );
  }

  void _onPasswordChanged(
    RegisterPasswordChanged event,
    Emitter<RegisterState> emit,
  ) {
    final passwordError =
        event.password.isEmpty
            ? 'Contraseña requerida'
            : !_isValidPassword(event.password)
            ? 'Mínimo 8 caracteres con mayúscula, número y carácter especial'
            : null;

    emit(
      state.copyWith(
        password: event.password,
        passwordError: passwordError,
        // Resetear error de confirmación si cambia la contraseña
        passwordRepeatError:
            state.passwordRepeat.isNotEmpty &&
                    event.password != state.passwordRepeat
                ? 'Las contraseñas no coinciden'
                : null,
      ),
    );
  }

  void _onPasswordRepeatChanged(
    RegisterPasswordRepeatChanged event,
    Emitter<RegisterState> emit,
  ) {
    emit(
      state.copyWith(
        passwordRepeat: event.passwordRepeat,
        passwordRepeatError:
            event.passwordRepeat.isEmpty
                ? 'Confirme la contraseña'
                : event.passwordRepeat != state.password
                ? 'Las contraseñas no coinciden'
                : null,
      ),
    );
  }

  Future<void> _onSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    // Validar todos los campos antes de enviar
    final firstNameError = state.firstName.isEmpty ? 'Nombre requerido' : null;
    final lastNameError = state.lastName.isEmpty ? 'Apellido requerido' : null;
    final aliasError = state.alias.isEmpty ? 'Alias requerido' : null;
    final emailError =
        state.email.isEmpty
            ? 'Email requerido'
            : !_isValidEmail(state.email)
            ? 'Email inválido'
            : null;
    final passwordError =
        state.password.isEmpty
            ? 'Contraseña requerida'
            : !_isValidPassword(state.password)
            ? 'Contraseña no cumple los requisitos'
            : null;
    final passwordRepeatError =
        state.passwordRepeat.isEmpty
            ? 'Confirme la contraseña'
            : state.password != state.passwordRepeat
            ? 'Las contraseñas no coinciden'
            : null;

    // Si hay algún error, actualizar el estado y abortar
    if (firstNameError != null ||
        lastNameError != null ||
        aliasError != null ||
        emailError != null ||
        passwordError != null ||
        passwordRepeatError != null) {
      emit(
        state.copyWith(
          firstNameError: firstNameError,
          lastNameError: lastNameError,
          aliasError: aliasError,
          emailError: emailError,
          passwordError: passwordError,
          passwordRepeatError: passwordRepeatError,
          isLoading: false,
        ),
      );
      return;
    }

    // Si todo es válido, proceder con el registro
    emit(state.copyWith(isLoading: true));

    try {
      final prefs = await SharedPreferences.getInstance();
      final countryCode = prefs.getString('user_country_code') ?? 'BR';

      final result = await registerUseCase.call(
        firstName: state.firstName,
        lastName: state.lastName,
        alias: state.alias,
        email: state.email,
        password: state.password,
        countryCode: countryCode,
      );

      result.fold(
        (failure) {
          emit(
            state.copyWith(
              isLoading: false,
              errorMessage: failure.message,
              isSuccess: false,
            ),
          );
        },
        (user) {
          emit(
            state.copyWith(
              isLoading: false,
              isSuccess: true,
              errorMessage: null,
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Error inesperado: ${e.toString()}',
        ),
      );
    }
  }
}
