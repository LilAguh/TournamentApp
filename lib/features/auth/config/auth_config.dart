import 'package:get_it/get_it.dart';
import 'package:tournament_app/core/network/api_user.dart';

import 'package:tournament_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:tournament_app/features/auth/data/datasources/auth_remote_data_source_impl.dart';
import 'package:tournament_app/features/auth/data/repositories/users_repository_impl.dart';
import 'package:tournament_app/features/auth/domain/repository/users_repository.dart';
import 'package:tournament_app/features/auth/domain/use_cases/login_use_cases.dart';
import 'package:tournament_app/features/auth/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

void initAuthConfig() {
  // Cliente HTTP centralizado
  sl.registerLazySingleton(
    () => ApiUser(dioUser: dioUser),
  ); // ya tenés Dio creado

  // Remote data source
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(apiUser: sl()),
  );

  // Repository
  sl.registerLazySingleton<UsersRepository>(
    () => UsersRepositoryImpl(remoteDataSource: sl()),
  );

  // Use Case
  sl.registerLazySingleton(() => LoginUseCase(repository: sl()));

  // bloc
  sl.registerFactory(() => AuthBloc(loginUseCase: sl()));
}
