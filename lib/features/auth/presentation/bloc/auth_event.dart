abstract class AuthEvent {}

// class LoginRequested extends AuthEvent {
//   final String alias;
//   final String password;

//   LoginRequested({required this.alias, required this.password});
// }

// class LogoutRequested extends AuthEvent {}

class AuthAliasChanged extends AuthEvent {
  final String alias;
  AuthAliasChanged(this.alias);
}

class AuthPasswordChanged extends AuthEvent {
  final String password;
  AuthPasswordChanged(this.password);
}

class AuthSubmitted extends AuthEvent {}

class SelectCoutryRegister extends AuthEvent {
  final String countryId;
  SelectCoutryRegister(this.countryId);
}

class AuthLogoutRequested extends AuthEvent {}
