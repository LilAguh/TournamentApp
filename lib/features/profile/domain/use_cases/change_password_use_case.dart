import 'package:dartz/dartz.dart';
import 'package:tournament_app/core/error/failure.dart';
import 'package:tournament_app/features/profile/domain/repository/profile_repository.dart';

class ChangePasswordUseCase {
  final ProfileRepository repository;

  ChangePasswordUseCase(this.repository);

  Future<Either<Failure, void>> call(
    int userId,
    String newPassword,
    String password,
    String token,
  ) {
    return repository.changePassword(userId, newPassword, password, token);
  }
}
