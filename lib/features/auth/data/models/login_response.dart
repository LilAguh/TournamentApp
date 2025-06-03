import 'package:tournament_app/features/auth/domain/entities/user.dart';

// TODO: pasar el LoginResponse a domain/entities
// Crear LoginResponseModel que extiende de LoginResponse
// En data irían las factorizaciones
// Se realizaría el mismo proceso que con UserModel - User

class LoginResponse {
  final String token;
  final User user;

  LoginResponse({required this.token, required this.user});
}
