import 'package:tournament_app/features/profile/domain/entities/profile.dart';

abstract class ProfileRemoteDataSource {
  Future<Profile> getProfile(int userId, String token);
  Future<void> updateProfile(Profile profile, String token);
  Future<void> deactivateAccount(int userId, String token);
  Future<void> deleteAccount(int userId, String token);
  Future<void> changePassword(
    int userId,
    String newPassword,
    String password,
    String token,
  );
}
