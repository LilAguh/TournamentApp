import 'package:dartz/dartz.dart';
import 'package:tournament_app/core/error/failure.dart';
import 'package:tournament_app/features/profile/domain/repository/profile_repository.dart';

class DeactivateAccountUseCase {
  final ProfileRepository repository;

  DeactivateAccountUseCase(this.repository);

  Future<Either<Failure, void>> call(int userId, String token) {
    return repository.deactivateAccount(userId, token);
  }
}
