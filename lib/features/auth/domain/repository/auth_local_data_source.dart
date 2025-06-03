import 'package:tournament_app/features/auth/domain/entities/user.dart';

abstract interface class AuthLocalDataSource {
  Future<void> saveAuthData({required String token, required UserRole role});

  Future<String?> getToken();
  Future<UserRole?> getRole();

  Future<void> clearSession();
}
