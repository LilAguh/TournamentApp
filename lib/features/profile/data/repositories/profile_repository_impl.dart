import 'package:dartz/dartz.dart';
import 'package:tournament_app/core/error/failure.dart';
import 'package:tournament_app/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:tournament_app/features/profile/domain/entities/profile.dart';
import 'package:tournament_app/features/profile/domain/repository/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  final ProfileRemoteDataSource localDataSource;

  ProfileRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, Profile>> getProfile(int userId, String token) async {
    try {
      final profile = await remoteDataSource.getProfile(userId, token);
      return Right(profile);
    } catch (e) {
      print('[PROFILE][ERROR] Exception: $e'); // ← AÑADÍ ESTO
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
  Future<Either<Failure, void>> changePassword({
    required int userId,
    required String password,
    required String newPassword,
    required String token,
  }) async {
    try {
      await remoteDataSource.changePassword(
        userId: userId,
        password: password,
        newPassword: newPassword,
        token: token,
      );
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(message: 'Error al cambiar la contraseña'));
    }
  }
}
