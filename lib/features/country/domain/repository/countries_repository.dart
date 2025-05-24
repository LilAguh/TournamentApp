import 'package:dartz/dartz.dart';
import 'package:tournament_app/core/error/failure.dart';
import 'package:tournament_app/features/country/domain/entities/country.dart';

abstract class CountriesRepository {
  Future<List<Country>> getCountries();
}
