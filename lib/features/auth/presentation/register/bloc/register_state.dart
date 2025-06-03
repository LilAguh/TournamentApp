class RegisterState {
  final String firstName;
  final String lastName;
  final String alias;
  final String email;
  final String password;
  final String passwordRepeat;
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  final String? firstNameError;
  final String? lastNameError;
  final String? aliasError;
  final String? emailError;
  final String? passwordError;
  final String? passwordRepeatError;
  final Set<String> validatedFields;

  const RegisterState({
    required this.firstName,
    required this.lastName,
    required this.alias,
    required this.email,
    required this.password,
    required this.passwordRepeat,
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
    this.firstNameError,
    this.lastNameError,
    this.aliasError,
    this.emailError,
    this.passwordError,
    this.passwordRepeatError,
    this.validatedFields = const {}, // Inicialmente vacío
  });

  factory RegisterState.initial() => const RegisterState(
    firstName: '',
    lastName: '',
    alias: '',
    email: '',
    password: '',
    passwordRepeat: '',
  );

  RegisterState copyWith({
    String? firstName,
    String? lastName,
    String? alias,
    String? email,
    String? password,
    String? passwordRepeat,
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    String? firstNameError,
    String? lastNameError,
    String? aliasError,
    String? emailError,
    String? passwordError,
    String? passwordRepeatError,
    Set<String>? validatedFields,
  }) {
    return RegisterState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      alias: alias ?? this.alias,
      email: email ?? this.email,
      password: password ?? this.password,
      passwordRepeat: passwordRepeat ?? this.passwordRepeat,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
      firstNameError: firstNameError,
      lastNameError: lastNameError,
      aliasError: aliasError,
      emailError: emailError,
      passwordError: passwordError,
      passwordRepeatError: passwordRepeatError,
      validatedFields: validatedFields ?? this.validatedFields,
    );
  }
}
