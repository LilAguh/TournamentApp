class Profile {
  final int id;
  final String email;
  final String alias;
  final String passwordHash;
  final String countryCode;
  final String avatarUrl;
  final String createdAt;
  final String? lastLogin;
  final bool isActive;

  Profile({
    required this.id,
    required this.alias,
    required this.email,
    required this.countryCode,
    required this.passwordHash,
    required this.avatarUrl,
    this.lastLogin,
    required this.isActive,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
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
      email: json['email'],
      alias: json['alias'],
      passwordHash: json['passwordHash'],
      countryCode: json['countryCode'],
      avatarUrl: json['avatarUrl'],
      createdAt: json['createdAt'],
      lastLogin: json['lastLogin'],
      isActive: json['isActive'],
    );
  }

  Profile copyWith({
    int? id,
    String? email,
    String? alias,
    String? passwordHash,
    String? countryCode,
    String? avatarUrl,
    String? createdAt,
    String? lastLogin,
    bool? isActive,
  }) {
    return Profile(
      id: id ?? this.id,
      email: email ?? this.email,
      alias: alias ?? this.alias,
      passwordHash: passwordHash ?? this.passwordHash,
      countryCode: countryCode ?? this.countryCode,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      createdAt: createdAt ?? this.createdAt,
      lastLogin: lastLogin ?? this.lastLogin,
      isActive: isActive ?? this.isActive,
    );
  }
}
