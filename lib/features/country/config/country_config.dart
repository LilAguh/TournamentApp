import 'package:get_it/get_it.dart';
import 'package:tournament_app/core/network/api_user.dart';

import 'package:tournament_app/features/country/data/datasources/country_remote_data_source.dart';
import 'package:tournament_app/features/country/data/datasources/country_remote_data_source_impl.dart';
import 'package:tournament_app/features/country/data/repositories/country_repository_impl.dart';
import 'package:tournament_app/features/country/domain/repository/countries_repository.dart';
import 'package:tournament_app/features/country/domain/use_case.dart/get_countries_use_cases.dart';
import 'package:tournament_app/features/country/presentation/bloc/country_bloc.dart';

final sl = GetIt.instance;

void initCountryConfig() {
  // ✅ Este es el que te falta
  sl.registerLazySingleton<CountryRemoteDataSource>(
    () => CountryRemoteDataSourceImpl(apiUser: sl()),
  );

  sl.registerLazySingleton<CountriesRepository>(
    () => CountryRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton(() => GetCountriesUseCases(repository: sl()));

  sl.registerFactory(() => CountryBloc(getCountriesUseCases: sl()));
}
