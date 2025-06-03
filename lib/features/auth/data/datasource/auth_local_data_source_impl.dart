import 'package:shared_preferences/shared_preferences.dart';
import 'package:tournament_app/features/auth/domain/entities/user.dart';
import '../../domain/repository/auth_local_data_source.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences prefs;

  AuthLocalDataSourceImpl({required this.prefs});

  static const _tokenKey = 'authToken';
  static const _roleKey = 'userRole';

  @override
  Future<void> saveAuthData({
    required String token,
    required UserRole role,
  }) async {
    await prefs.setString(_tokenKey, token);
    await prefs.setInt(_roleKey, _mapUserRoleToInt(role));
  }

  @override
  Future<String?> getToken() async {
    return prefs.getString(_tokenKey);
  }

  @override
  Future<UserRole?> getRole() async {
    final roleId = prefs.getInt(_roleKey);
    if (roleId == null) return null;
    return _mapIntToUserRole(roleId);
  }

  @override
  Future<void> clearSession() async {
    await prefs.remove(_tokenKey);
    await prefs.remove(_roleKey);
  }

  // Reutilizamos estos helpers (podés moverlos a una clase común si querés)
  int _mapUserRoleToInt(UserRole role) =>
      {
        UserRole.player: 1,
        UserRole.admin: 2,
        UserRole.judge: 3,
        UserRole.organizer: 4,
      }[role]!;

  UserRole _mapIntToUserRole(int id) =>
      {
        1: UserRole.player,
        2: UserRole.admin,
        3: UserRole.judge,
        4: UserRole.organizer,
      }[id]!;
}
