import 'package:tournament_app/features/profile/domain/entities/profile.dart';

abstract class ProfileEvent {}

class LoadProfile extends ProfileEvent {
  final int userId;
  LoadProfile(this.userId);
}

class UpdateProfileEvent extends ProfileEvent {
  UpdateProfileEvent();
}

class DeactivateAccountEvent extends ProfileEvent {
  final int userId;
  DeactivateAccountEvent(this.userId);
}

class DeleteAccountEvent extends ProfileEvent {
  final int userId;
  DeleteAccountEvent(this.userId);
}

class ChangePasswordEvent extends ProfileEvent {
  final int userId;
  ChangePasswordEvent(this.userId);
}

class AliasChanged extends ProfileEvent {
  final String alias;
  AliasChanged(this.alias);
}

class EmailChanged extends ProfileEvent {
  final String email;
  EmailChanged(this.email);
}

class CountryCodeChanged extends ProfileEvent {
  final String countryCode;
  CountryCodeChanged(this.countryCode);
}

class AvatarUrlChanged extends ProfileEvent {
  final String avatarUrl;
  AvatarUrlChanged(this.avatarUrl);
}

class CurrentPasswordChanged extends ProfileEvent {
  final String currentPassword;
  CurrentPasswordChanged(this.currentPassword);
}

class NewPasswordChanged extends ProfileEvent {
  final String newPassword;
  NewPasswordChanged(this.newPassword);
}
