import 'package:dartz/dartz.dart';
import 'package:tournament_app/core/error/failure.dart';
import 'package:tournament_app/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:tournament_app/features/profile/domain/entities/profile.dart';
import 'package:tournament_app/features/profile/domain/repository/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Profile>> getProfile(int userId, String token) async {
    try {
      final result = await remoteDataSource.getProfile(userId, token);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: 'Error al obtener el perfil'));
    }
  }

  @override
  Future<Either<Failure, void>> updateProfile(
    Profile profile,
    String token,
  ) async {
    try {
      await remoteDataSource.updateProfile(profile, token);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: 'Error al actualizar perfil'));
    }
  }

  @override
  Future<Either<Failure, void>> deactivateAccount(
    int userId,
    String token,
  ) async {
    try {
      await remoteDataSource.deactivateAccount(userId, token);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: 'Error al desactivar cuenta'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAccount(int userId, String token) async {
    try {
      await remoteDataSource.deleteAccount(userId, token);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: 'Error al eliminar cuenta'));
    }
  }

  @override
  Future<Either<Failure, void>> changePassword(
    int userId,
    String newPassword,
    String password,
    String token,
  ) async {
    try {
      await remoteDataSource.changePassword(
        userId,
        newPassword,
        password,
        token,
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: 'Error al cambiar contraseña'));
    }
  }
}
