import 'package:dartz/dartz.dart';
import 'package:tournament_app/core/error/failure.dart';
import 'package:tournament_app/features/profile/domain/entities/profile.dart';

abstract class ProfileRepository {
  Future<Either<Failure, Profile>> getProfile(int userId, String token);
  Future<Either<Failure, void>> updateProfile(Profile profile, String token);
  Future<Either<Failure, void>> deactivateAccount(int userId, String token);
  Future<Either<Failure, void>> deleteAccount(int userId, String token);
  Future<Either<Failure, void>> changePassword({
    required int userId,
    required String password,
    required String newPassword,
    required String token,
  });
}
