import 'package:dartz/dartz.dart';
import 'package:tournament_app/core/error/failure.dart';
import 'package:tournament_app/features/profile/domain/repository/profile_repository.dart';

class ChangePasswordUseCase {
  final ProfileRepository repository;

  ChangePasswordUseCase({required this.repository});

  Future<Either<Failure, void>> call({
    required int userId,
    required String newPassword,
    required String password,
    required String token,
  }) async {
    return await repository.changePassword(
      userId: userId,
      password: password,
      newPassword: newPassword,
      token: token,
    );
  }
}
