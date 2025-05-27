import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tournament_app/core/network/api_dio.dart';
import 'package:tournament_app/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:tournament_app/features/auth/data/datasources/auth_local_data_source_impl.dart';

import 'package:tournament_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:tournament_app/features/auth/data/datasources/auth_remote_data_source_impl.dart';
import 'package:tournament_app/features/auth/data/repositories/users_repository_impl.dart';
import 'package:tournament_app/features/auth/domain/repository/users_repository.dart';
import 'package:tournament_app/features/auth/domain/use_cases/login_use_cases.dart';
import 'package:tournament_app/features/auth/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> initAuthConfig() async {
  // Cliente HTTP centralizado
  sl.registerLazySingleton(
    () => ApiDio(dioUser: dioUser),
  ); // ya tenés Dio creado

  // Remote data source
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(apiDio: sl()),
  );

  // Repository
  sl.registerLazySingleton<UsersRepository>(
    () => UsersRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()),
  );

  // Use Case
  sl.registerLazySingleton(() => LoginUseCase(repository: sl()));

  // bloc
  sl.registerFactory(() => AuthBloc(loginUseCase: sl()));

  // SharedPreferences
  final prefs = await SharedPreferences.getInstance();

  sl.registerLazySingleton<SharedPreferences>(() => prefs);
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(prefs: sl()),
  );
}
