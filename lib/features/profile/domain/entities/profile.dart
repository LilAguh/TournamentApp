import 'package:tournament_app/features/auth/domain/enum/user_role.dart';

class Profile {
  final int id;
  final UserRole role;
  final String firstName;
  final String lastName;
  final String alias;
  final String email;
  final String countryCode;
  final String avatarUrl;
  final DateTime? lastLogin;
  final bool isActive;

  Profile({
    required this.id,
    required this.role,
    required this.firstName,
    required this.lastName,
    required this.alias,
    required this.email,
    required this.countryCode,
    required this.avatarUrl,
    this.lastLogin,
    required this.isActive,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'role': _mapUserRoleToInt(role),
      'firstName': firstName,
      'lastName': lastName,
      'alias': alias,
      'email': email,
      'countryCode': countryCode,
      'avatarUrl': avatarUrl,
      'lastLogin': lastLogin,
      'isActive': isActive,
    };
  }

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      role: json['role'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      alias: json['alias'],
      email: json['email'],
      countryCode: json['countryCode'],
      avatarUrl: json['avatarUrl'],
      lastLogin:
          json['lastLogin'] != null ? DateTime.parse(json['lastLogin']) : null,
      isActive: json['isActive'],
    );
  }

  Profile copyWith({
    String? alias,
    String? email,
    String? countryCode,
    String? avatarUrl,
  }) {
    return Profile(
      id: id,
      role: role,
      firstName: firstName,
      lastName: lastName,
      alias: alias ?? this.alias,
      email: email ?? this.email,
      countryCode: countryCode ?? this.countryCode,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      lastLogin: lastLogin,
      isActive: isActive,
    );
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
