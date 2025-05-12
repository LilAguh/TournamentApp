import 'package:dartz/dartz.dart';
import 'package:tournament_app/core/error/failure.dart';
import 'package:tournament_app/features/auth/domain/repository/users_repository.dart';
import 'package:tournament_app/features/auth/domain/entities/user.dart';

class RegisterUseCase {
  final UsersRepository repository;

  RegisterUseCase({required this.repository});

  Future<Either<Failure, User>> call({
    required String firstName,
    required String lastName,
    required String alias,
    required String email,
    required String password,
    required String countryCode,
    required String avatarUrl,
  }) async {
    return await repository.register(
      firstName: firstName,
      lastName: lastName,
      alias: alias,
      email: email,
      password: password,
      countryCode: countryCode,
      avatarUrl: avatarUrl,
    );
  }
}
