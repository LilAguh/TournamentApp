import 'package:dio/dio.dart';

final Dio dioUser = Dio(
  BaseOptions(
    baseUrl: 'http://192.168.0.243:5181/',
    // baseUrl: 'https://6738-181-97-134-247.ngrok-free.app/',
    contentType: 'application/json',
    headers: <String, String>{'Accept': 'application/json'},
  ),
);

enum HttpMethod { get, post, put, patch, delete }

class ApiDio {
  final Dio dioUser;

  ApiDio({required this.dioUser});

  Future<Response> request({
    required HttpMethod method,
    required String url,
    dynamic body,
  }) async {
    try {
      final result = await dioUser.request(
        url,
        data: body,
        options: Options(
          method: method.name.toUpperCase(),
          responseType: ResponseType.json,
        ),
      );

      return result;
    } on DioException catch (e) {
      return e.response!;
    } catch (e) {
      return Response(
        requestOptions: RequestOptions(path: url),
        statusCode: 500,
        statusMessage: 'Error: $e',
        data: 'An unexpected error occurred',
      );
    }
  }
}
