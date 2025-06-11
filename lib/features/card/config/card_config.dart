import 'package:tournament_app/features/card/data/datasources/card_remote_data_source.dart';
import 'package:tournament_app/features/card/data/datasources/card_remote_data_source_impl.dart';
import 'package:tournament_app/features/card/data/repositories/card_repository_impl.dart';
import 'package:tournament_app/features/card/domain/repository/card_repository.dart';
import 'package:tournament_app/features/card/domain/use_cases/get_all_cards_use_case.dart';
import 'package:tournament_app/features/card/presentation/bloc/card_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void initCardFeature() {
  sl.registerLazySingleton<CardRemoteDataSource>(
    () => CardRemoteDataSourceImpl(),
  );

  sl.registerLazySingleton<CardRepository>(
    () => CardRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton(() => GetAllCardsUseCase(sl()));

  sl.registerFactory(() => CardBloc(getAllCardsUseCase: sl()));
}
