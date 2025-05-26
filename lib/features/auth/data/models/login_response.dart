import 'package:tournament_app/features/auth/domain/entities/user.dart';

class LoginResponse {
  final String token;
  final User user;

  LoginResponse({required this.token, required this.user});
}
