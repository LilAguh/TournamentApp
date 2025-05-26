import 'package:tournament_app/features/auth/domain/enum/user_role.dart';

abstract class AuthLocalDataSource {
  Future<void> saveAuthData({required String token, required UserRole role});

  Future<String?> getToken();
  Future<UserRole?> getRole();

  Future<void> clearSession();
}
