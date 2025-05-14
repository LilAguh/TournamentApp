abstract class AuthEvent {}

class LoginRequested extends AuthEvent {
  final String alias;
  final String password;

  LoginRequested({required this.alias, required this.password});
}

class LogoutRequested extends AuthEvent {}
