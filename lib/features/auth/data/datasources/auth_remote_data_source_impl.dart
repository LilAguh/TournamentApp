import 'package:tournament_app/core/network/api_user.dart';
import 'package:tournament_app/features/auth/domain/entities/user.dart';
import 'package:tournament_app/features/auth/data/datasources/auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiUser apiUser;

  AuthRemoteDataSourceImpl({required this.apiUser});

  @override
  Future<User> login(String alias, String password) async {
    final response = await apiUser.request(
      method: HttpMethod.post,
      url: 'Auth/Login',
      body: {'alias': alias, 'password': password},
    );

    if (response.statusCode == 200) {
      // Acá asumimos que el backend devuelve:
      // {
      //   "token": "...",
      //   "user": { "id": ..., "alias": ..., etc. }
      // }
      return User.fromJson(response.data['user']);
    } else {
      throw Exception(response.statusMessage ?? 'Error al iniciar sesión');
    }
  }
}
