import 'package:dartz/dartz.dart';
import 'package:tournament_app/core/error/failure.dart';
import 'package:tournament_app/features/profile/domain/entities/profile.dart';
import 'package:tournament_app/features/profile/domain/repository/profile_repository.dart';

class UpdateProfileUseCase {
  final ProfileRepository repository;

  UpdateProfileUseCase({required this.repository});

  Future<Either<Failure, void>> call({
    required Profile profile,
    required String token,
  }) async {
    return await repository.updateProfile(profile, token);
  }
}
