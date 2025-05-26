import 'package:dartz/dartz.dart';
import 'package:tournament_app/core/error/failure.dart';
import 'package:tournament_app/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:tournament_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:tournament_app/features/auth/data/models/login_response.dart';
import 'package:tournament_app/features/auth/domain/entities/user.dart';
import 'package:tournament_app/features/auth/domain/repository/users_repository.dart';

class UsersRepositoryImpl implements UsersRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  UsersRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, User>> login({
    required String alias,
    required String password,
  }) async {
    try {
      final loginResponse = await remoteDataSource.login(alias, password);
      await localDataSource.saveAuthData(
        token: loginResponse.token,
        role: loginResponse.user.role,
      );
      return Right(loginResponse.user);
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      } else {
        return left(ServerFailure(message: "Error inesperado"));
      }
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
