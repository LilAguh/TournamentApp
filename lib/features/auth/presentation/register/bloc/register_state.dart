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
    );
  }
}
