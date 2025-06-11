import 'package:dartz/dartz.dart';
import 'package:tournament_app/core/error/failure.dart';
import 'package:tournament_app/features/profile/domain/entities/profile.dart';
import 'package:tournament_app/features/profile/domain/repository/profile_repository.dart';

class GetProfileUseCase {
  final ProfileRepository repository;

  GetProfileUseCase({required this.repository});

  Future<Either<Failure, Profile>> call({
    required int userId,
    required String token,
  }) async {
    return await repository.getProfile(userId, token);
  }
}
