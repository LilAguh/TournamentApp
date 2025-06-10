import 'package:dartz/dartz.dart';
import 'package:tournament_app/core/error/failure.dart';
import 'package:tournament_app/features/profile/domain/entities/profile.dart';

abstract class ProfileRepository {
  Future<Either<Failure, Profile>> getProfile(int userId, String token);
  Future<Either<Failure, void>> updateProfile(Profile profile, String token);
  Future<Either<Failure, void>> deactivateAccount(int userId, String token);
  Future<Either<Failure, void>> deleteAccount(int userId, String token);
  Future<Either<Failure, void>> changePassword(
    int userId,
    String newPassword,
    String password,
    String token,
  );
}
