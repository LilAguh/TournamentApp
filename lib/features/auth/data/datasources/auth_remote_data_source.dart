import 'package:tournament_app/features/auth/domain/entities/user.dart';

abstract class AuthRemoteDataSource {
  Future<User> login(String alias, String password);

  // Agregá otros métodos como register, logout, etc. más adelante
}
