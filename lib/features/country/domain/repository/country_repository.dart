import 'package:tournament_app/features/country/domain/entities/country.dart';

abstract class CountryRepository {
  Future<List<Country>> getCountries();
}
