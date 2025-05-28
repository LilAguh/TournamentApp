import 'package:tournament_app/core/error/failure.dart';
import 'package:tournament_app/core/network/api_dio.dart';
import 'package:tournament_app/features/auth/data/models/login_response.dart';
import 'package:tournament_app/features/auth/domain/entities/user.dart';
import 'package:tournament_app/features/auth/data/datasources/auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiDio apiDio;

  AuthRemoteDataSourceImpl({required this.apiDio});

  @override
  Future<LoginResponse> login(String alias, String password) async {
    final response = await apiDio.request(
      method: HttpMethod.post,
      url: 'Auth/Login',
      body: {'alias': alias, 'password': password},
    );

    if (response.statusCode == 200) {
      // extraemos token y datos de usuario por separado
      final token = response.data['token'] as String;
      final userJson = response.data['user'];
      final user = User.fromJson(userJson);

      print(token);
      print(user.role);

      return LoginResponse(token: token, user: user);
    } else {
      final data = response.data;

      final message =
          data != null && data['Message'] != null
              ? data['Message'] as String
              : 'Error desconocido';

      print('Mensaje de error: $message');
      throw ServerFailure(message: message);
    }
  }

  @override
  Future<User> register({
    required String firstName,
    required String lastName,
    required String alias,
    required String email,
    required String password,
    required String countryCode,
  }) async {
    final response = await apiDio.request(
      method: HttpMethod.post,
      url: 'User/Register',
      body: {
        'firstName': firstName,
        'lastName': lastName,
        'alias': alias,
        'email': email,
        'password': password,
        'countryCode': countryCode,
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      // ✅ FIX: el backend devuelve directamente el user
      final data = response.data;
      print('[DataSource] Usuario recibido: $data');
      return User.fromJson(data);
    } else {
      final message = response.data['Message'] ?? 'Error al registrar usuario';
      throw ServerFailure(message: message);
    }
  }
}
