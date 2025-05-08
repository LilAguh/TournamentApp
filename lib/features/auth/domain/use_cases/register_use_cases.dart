import 'package:dartz/dartz.dart';
import 'package:tournament_app/core/error/failure.dart';
import 'package:tournament_app/features/auth/domain/repository/users_repository.dart';
import 'package:tournament_app/features/auth/domain/entities/user.dart';

class RegisterUseCase {
  final UsersRepository repository;

  RegisterUseCase({required this.repository});

  Future<Either<Failure, User>> call(
    String firstName,
    String lastName,
    String alias,
    String email,
    String password,
    String countryCode,
    String avatarUrl,
  ) {
    return repository.register(
      firstName,
      lastName,
      alias,
      email,
      password,
      countryCode,
      avatarUrl,
    );
  }
}
