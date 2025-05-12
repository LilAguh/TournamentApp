import 'package:tournament_app/features/auth/domain/enum/user_role.dart';

class User {
  final int id;
  final UserRole role;
  final String alias;
  final String email;

  User({
    required this.id,
    required this.role,
    required this.alias,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'role': _mapUserRoleToInt(role),
      'alias': alias,
      'email': email,
    };
  }

  factory User.fromJson(json) {
    return User(
      id: json['id'],
      role: _mapIntToUserRole(json['role']),
      alias: json['alias'],
      email: json['email'],
    );
  }

  static UserRole _mapIntToUserRole(int roleId) {
    switch (roleId) {
      case 1:
        return UserRole.player;
      case 2:
        return UserRole.admin;
      case 3:
        return UserRole.judge;
      case 4:
        return UserRole.organizer;
      default:
        throw Exception('Rol no válido: $roleId');
    }
  }

  static int _mapUserRoleToInt(UserRole role) {
    switch (role) {
      case UserRole.player:
        return 1;
      case UserRole.admin:
        return 2;
      case UserRole.judge:
        return 3;
      case UserRole.organizer:
        return 4;
    }
  }
}
