import 'package:tournament_app/features/auth/data/models/login_response.dart';
import 'package:tournament_app/features/auth/domain/entities/user.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponse> login(String alias, String password);

  // Agregá otros métodos como register, logout, etc. más adelante
}
