class User {
  final int Id;
  final Enum Role;
  final String FirstName;
  final String LastName;
  final String Alias;
  final String Email;
  final String HashedPassword;
  final String CountryCode;
  final String AvatarUrl;
  final DateTime CreatedAt;
  final DateTime? LastLogin;
  final bool IsActive;
  final int CreatedBy;

  User({
    required this.Id,
    required this.Role,
    required this.FirstName,
    required this.LastName,
    required this.Alias,
    required this.Email,
    required this.HashedPassword,
    required this.CountryCode,
    required this.AvatarUrl,
    required this.CreatedAt,
    required this.LastLogin,
    required this.IsActive,
    required this.CreatedBy,
  });
}
