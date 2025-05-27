import 'package:tournament_app/features/country/data/datasources/country_remote_data_source.dart';
import 'package:tournament_app/features/country/domain/entities/country.dart';
import 'package:tournament_app/features/country/domain/repository/country_repository.dart';

class CountryRepositoryImpl implements CountryRepository {
  final CountryRemoteDataSource remoteDataSource;

  CountryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Country>> getCountries() {
    return remoteDataSource.getCountries();
  }
}
