import 'package:tournament_app/features/profile/domain/entities/profile.dart';

class ProfileState {
  final Profile? profile;
  final bool isLoading;
  final bool success;
  final String? errorMessage;

  final String alias;
  final String email;
  final String countryCode;
  final String avatarUrl;
  final String currentPassword;
  final String newPassword;

  const ProfileState({
    this.profile,
    this.isLoading = false,
    this.success = false,
    this.errorMessage,
    this.alias = '',
    this.email = '',
    this.countryCode = '',
    this.avatarUrl = '',
    this.currentPassword = '',
    this.newPassword = '',
  });

  ProfileState copyWith({
    Profile? profile,
    bool? isLoading,
    bool? success,
    String? errorMessage,
    String? alias,
    String? email,
    String? countryCode,
    String? avatarUrl,
    String? currentPassword,
    String? newPassword,
  }) {
    return ProfileState(
      profile: profile ?? this.profile,
      isLoading: isLoading ?? this.isLoading,
      success: success ?? this.success,
      errorMessage: errorMessage,
      alias: alias ?? this.alias,
      email: email ?? this.email,
      countryCode: countryCode ?? this.countryCode,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      currentPassword: currentPassword ?? this.currentPassword,
      newPassword: newPassword ?? this.newPassword,
    );
  }
}
