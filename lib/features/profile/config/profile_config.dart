import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tournament_app/core/network/api_dio.dart';
import 'package:tournament_app/features/profile/data/datasources/profile_local_data_source.dart';
import 'package:tournament_app/features/profile/data/datasources/profile_local_data_source_impl.dart';
import 'package:tournament_app/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:tournament_app/features/profile/data/datasources/profile_remote_data_source_impl.dart';
import 'package:tournament_app/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:tournament_app/features/profile/domain/repository/profile_repository.dart';
import 'package:tournament_app/features/profile/domain/use_cases/change_password_use_case.dart';
import 'package:tournament_app/features/profile/domain/use_cases/delete_account_use_case.dart';
import 'package:tournament_app/features/profile/domain/use_cases/desactivate_account_use_case.dart';
import 'package:tournament_app/features/profile/domain/use_cases/get_profile_use_case.dart';
import 'package:tournament_app/features/profile/domain/use_cases/update_profile_use_case.dart';
import 'package:tournament_app/features/profile/presentation/bloc/profile_bloc.dart';

final sl = GetIt.instance;

Future<void> initProfileConfig() async {
  // Local + Remote Data Sources
  sl.registerLazySingleton<ProfileLocalDataSource>(
    () => ProfileLocalDataSourceImpl(prefs: sl()),
  );

  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(apiDio: sl()),
  );

  // Repositorio
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()),
  );

  // Casos de uso
  sl.registerLazySingleton(() => GetProfileUseCase(repository: sl()));
  sl.registerLazySingleton(() => UpdateProfileUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeactivateAccountUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteAccountUseCase(repository: sl()));
  sl.registerLazySingleton(() => ChangePasswordUseCase(repository: sl()));

  // Bloc
  sl.registerFactory(
    () => ProfileBloc(
      getProfile: sl(),
      updateProfile: sl(),
      deactivateAccount: sl(),
      deleteAccount: sl(),
      changePassword: sl(),
      prefs: sl(),
    ),
  );
}
