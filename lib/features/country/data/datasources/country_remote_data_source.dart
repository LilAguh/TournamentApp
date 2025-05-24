import 'package:tournament_app/features/country/domain/entities/country.dart';

abstract class CountryRemoteDataSource {
  Future<List<Country>> getCountries();
}
