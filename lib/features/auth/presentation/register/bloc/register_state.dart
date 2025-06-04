class RegisterState {
  final String firstName;
  final String lastName;
  final String alias;
  final String email;
  final String password;
  final String passwordRepeat;

  final bool isFirstNameValid;
  final bool isLastNameValid;
  final bool isAliasValid;
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isPasswordRepeatValid;

  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;

  const RegisterState({
    required this.firstName,
    required this.lastName,
    required this.alias,
    required this.email,
    required this.password,
    required this.passwordRepeat,
    required this.isFirstNameValid,
    required this.isLastNameValid,
    required this.isAliasValid,
    required this.isEmailValid,
    required this.isPasswordValid,
    required this.isPasswordRepeatValid,
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  factory RegisterState.initial() => const RegisterState(
    firstName: '',
    lastName: '',
    alias: '',
    email: '',
    password: '',
    passwordRepeat: '',
    isFirstNameValid: false,
    isLastNameValid: false,
    isAliasValid: false,
    isEmailValid: false,
    isPasswordValid: false,
    isPasswordRepeatValid: false,
  );

  RegisterState copyWith({
    String? firstName,
    String? lastName,
    String? alias,
    String? email,
    String? password,
    String? passwordRepeat,
    bool? isFirstNameValid,
    bool? isLastNameValid,
    bool? isAliasValid,
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? isPasswordRepeatValid,
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return RegisterState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      alias: alias ?? this.alias,
      email: email ?? this.email,
      password: password ?? this.password,
      passwordRepeat: passwordRepeat ?? this.passwordRepeat,
      isFirstNameValid: isFirstNameValid ?? this.isFirstNameValid,
      isLastNameValid: isLastNameValid ?? this.isLastNameValid,
      isAliasValid: isAliasValid ?? this.isAliasValid,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isPasswordRepeatValid:
          isPasswordRepeatValid ?? this.isPasswordRepeatValid,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
    );
  }
}
