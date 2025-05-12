import 'package:dartz/dartz.dart';
import 'package:tournament_app/core/error/failure.dart';
import 'package:tournament_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:tournament_app/features/auth/domain/entities/user.dart';
import 'package:tournament_app/features/auth/domain/repository/users_repository.dart';

class UsersRepositoryImpl implements UsersRepository {
  final AuthRemoteDataSource remoteDataSource;

  UsersRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, User>> login({
    required String alias,
    required String password,
  }) async {
    try {
      final user = await remoteDataSource.login(alias, password);
      return Right(user);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> register({
    required String firstName,
    required String lastName,
    required String alias,
    required String email,
    required String password,
    required String countryCode,
    required String avatarUrl,
  }) {
    throw UnimplementedError('register() no implementado todavía');
  }
}
