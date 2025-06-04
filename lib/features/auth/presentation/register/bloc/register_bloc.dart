import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tournament_app/features/auth/domain/use_cases/register_use_cases.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterBloc({required this.registerUseCase})
    : super(RegisterState.initial()) {
    on<RegisterFirstNameChanged>((event, emit) {
      final isValid = event.firstName.trim().isNotEmpty;
      emit(
        state.copyWith(firstName: event.firstName, isFirstNameValid: isValid),
      );
    });

    on<RegisterLastNameChanged>((event, emit) {
      final isValid = event.lastName.trim().isNotEmpty;
      emit(state.copyWith(lastName: event.lastName, isLastNameValid: isValid));
    });

    on<RegisterAliasChanged>((event, emit) {
      final isValid = event.alias.trim().isNotEmpty;
      emit(state.copyWith(alias: event.alias, isAliasValid: isValid));
    });

    on<RegisterEmailChanged>((event, emit) {
      final isValid = _isEmailValid(event.email);
      emit(state.copyWith(email: event.email, isEmailValid: isValid));
    });

    on<RegisterPasswordChanged>((event, emit) {
      final isValid = _isPasswordStrong(event.password);
      final match = event.password == state.passwordRepeat;
      emit(
        state.copyWith(
          password: event.password,
          isPasswordValid: isValid,
          isPasswordRepeatValid: match,
        ),
      );
    });

    on<RegisterPasswordRepeatChanged>((event, emit) {
      final match = event.passwordRepeat == state.password;
      emit(
        state.copyWith(
          passwordRepeat: event.passwordRepeat,
          isPasswordRepeatValid: match,
        ),
      );
    });

    on<RegisterSubmitted>((event, emit) async {
      emit(state.copyWith(isLoading: true, errorMessage: null));
      final result = await registerUseCase.call(
        firstName: state.firstName,
        lastName: state.lastName,
        alias: state.alias,
        email: state.email,
        password: state.password,
        countryCode: 'BR',
      );

      result.fold(
        (failure) => emit(
          state.copyWith(isLoading: false, errorMessage: failure.message),
        ),
        (_) => emit(state.copyWith(isLoading: false, isSuccess: true)),
      );
    });

    on<RegisterResetSuccess>((event, emit) {
      emit(state.copyWith(isSuccess: false));
    });
  }

  bool _isEmailValid(String email) {
    final regex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
    return regex.hasMatch(email);
  }

  bool _isPasswordStrong(String password) {
    final regex = RegExp(r'^(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$');
    return regex.hasMatch(password);
  }
}
