import 'package:tournament_app/features/auth/data/models/login_response.dart';
import 'package:tournament_app/features/auth/domain/entities/user.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponse> login(String alias, String password);
  Future<User> register({
    required String firstName,
    required String lastName,
    required String alias,
    required String email,
    required String password,
    required String countryCode,
  });

  // Agregá otros métodos como register, logout, etc. más adelante
}
