import 'package:dartz/dartz.dart';
import 'package:tournament_app/core/error/failure.dart';
import 'package:tournament_app/features/profile/domain/repository/profile_repository.dart';

class DeactivateAccountUseCase {
  final ProfileRepository repository;

  DeactivateAccountUseCase({required this.repository});

  Future<Either<Failure, void>> call({
    required int userId,
    required String token,
  }) async {
    return await repository.deactivateAccount(userId, token);
  }
}
