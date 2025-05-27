import 'package:get_it/get_it.dart';
import 'package:tournament_app/features/country/data/datasources/country_remote_data_source.dart';
import 'package:tournament_app/features/country/data/datasources/country_remote_data_source_impl.dart';
import 'package:tournament_app/features/country/data/repositories/country_repository_impl.dart';
import 'package:tournament_app/features/country/domain/repository/country_repository.dart';
import 'package:tournament_app/features/country/domain/use_cases/get_countries_use_cases.dart';
import 'package:tournament_app/features/country/presentation/bloc/country_bloc.dart';

final sl = GetIt.instance;

void initCountryConfig() {
  sl.registerLazySingleton<CountryRemoteDataSource>(
    () => CountryRemoteDataSourceImpl(apiDio: sl()),
  );

  sl.registerLazySingleton<CountryRepository>(
    () => CountryRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton(() => GetCountriesUseCases(repository: sl()));

  sl.registerFactory(() => CountryBloc(getCountriesUseCases: sl()));
}
