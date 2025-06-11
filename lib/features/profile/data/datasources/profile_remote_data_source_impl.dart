import 'package:dio/dio.dart';
import 'package:tournament_app/core/network/api_dio.dart';
import 'package:tournament_app/features/profile/domain/entities/profile.dart';
import 'profile_remote_data_source.dart';

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ApiDio apiDio;

  ProfileRemoteDataSourceImpl({required this.apiDio});

  @override
  Future<Profile> getProfile(int userId, String token) async {
    final response = await apiDio.dioUser.get(
      'User/$userId',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return Profile.fromJson(response.data);
  }

  @override
  Future<void> updateProfile(Profile profile, String token) async {
    await apiDio.dioUser.put(
      'User/${profile.id}',
      data: profile.toJson(),
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }

  @override
  Future<void> deactivateAccount(int userId, String token) async {
    await apiDio.dioUser.patch(
      'User/$userId',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }

  @override
  Future<void> deleteAccount(int userId, String token) async {
    await apiDio.dioUser.delete(
      'User/DeletePermanent/$userId',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }

  @override
  Future<void> changePassword({
    required int userId,
    required String newPassword,
    required String password,
    required String token,
  }) async {
    await apiDio.dioUser.patch(
      'User/ChangePassword/$userId',
      data: {'currentPassword': password, 'newPassword': newPassword},
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }
}
