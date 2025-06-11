import 'package:tournament_app/features/profile/domain/entities/profile.dart';

abstract class ProfileRemoteDataSource {
  Future<Profile> getProfile(int userId, String token);
  Future<void> updateProfile(Profile profile, String token);
  Future<void> deactivateAccount(int userId, String token);
  Future<void> deleteAccount(int userId, String token);
  Future<void> changePassword({
    required int userId,
    required String password,
    required String newPassword,
    required String token,
  });
}
