import 'package:tournament_app/core/network/api_dio.dart';
import 'package:tournament_app/features/country/data/datasources/country_remote_data_source.dart';
import 'package:tournament_app/features/country/domain/entities/country.dart';

class CountryRemoteDataSourceImpl implements CountryRemoteDataSource {
  final ApiDio apiDio;

  CountryRemoteDataSourceImpl({required this.apiDio});

  @override
  Future<List<Country>> getCountries() async {
    final response = await apiDio.request(
      method: HttpMethod.get,
      url: 'Countries/',
    );
    if (response.statusCode == 200) {
      final List data = response.data;
      return data.map((e) => Country.fromJson(e)).toList();
    } else {
      throw Exception(response.statusMessage ?? 'Error al obtener paises');
    }
  }
}
