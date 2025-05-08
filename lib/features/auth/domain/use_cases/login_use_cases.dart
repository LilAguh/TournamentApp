import 'package:dartz/dartz.dart';
import 'package:tournament_app/core/error/failure.dart';
import 'package:tournament_app/features/auth/domain/repository/users_repository.dart';
import 'package:tournament_app/features/auth/domain/entities/user.dart';

class LoginUseCase {
  final UsersRepository repository;

  LoginUseCase({required this.repository});

  Future<Either<Failure, User>> call(String alias, String password) {
    return repository.login(alias, password);
  }
}
