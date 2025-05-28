import 'package:tournament_app/features/country/data/datasources/country_remote_data_source.dart';
import 'package:tournament_app/features/country/domain/entities/country.dart';

class GetCountriesUseCases {
  final CountryRemoteDataSource repository;

  GetCountriesUseCases({required this.repository});

  Future<List<Country>> call() async {
    return await repository.getCountries();
  }
}
