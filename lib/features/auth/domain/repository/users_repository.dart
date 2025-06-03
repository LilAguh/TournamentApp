import 'package:tournament_app/core/error/failure.dart';
import 'package:tournament_app/features/auth/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

abstract interface class UsersRepository {
  Future<Either<Failure, User>> login({
    required String alias,
    required String password,
  });
  Future<Either<Failure, User>> register({
    required String firstName,
    required String lastName,
    required String alias,
    required String email,
    required String password,
    required String countryCode,
  });
}
