import 'package:tournament_app/core/error/failure.dart';
import 'package:tournament_app/features/auth/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

abstract class UsersRepository {
  Future<Either<Failure, User>> login(String email, String password);
  Future<Either<Failure, User>> register(
    String firstName,
    String lastName,
    String alias,
    String email,
    String password,
    String countryCode,
    String avatarUrl,
  );
}
