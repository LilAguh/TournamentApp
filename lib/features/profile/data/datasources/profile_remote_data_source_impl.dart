import 'package:dio/dio.dart';
import 'package:tournament_app/core/network/api_dio.dart';
import 'package:tournament_app/features/profile/domain/entities/profile.dart';
import 'profile_remote_data_source.dart';

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ApiDio api;

  ProfileRemoteDataSourceImpl({required this.api});

  @override
  Future<Profile> getProfile(int userId, String token) async {
    final response = await api.dioUser.get(
      'User/$userId',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return Profile.fromJson(response.data);
  }

  @override
  Future<void> updateProfile(Profile profile, String token) async {
    await api.dioUser.put(
      'User/${profile.id}',
      data: profile.toJson(),
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }

  @override
  Future<void> deactivateAccount(int userId, String token) async {
    await api.dioUser.patch(
      'User/$userId',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }

  @override
  Future<void> deleteAccount(int userId, String token) async {
    await api.dioUser.delete(
      'User/DeletePermanent/$userId',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }

  @override
  Future<void> changePassword(
    int userId,
    String newPassword,
    String password,
    String token,
  ) async {
    await api.dioUser.patch(
      'User/ChangePassword/$userId',
      data: {'currentPassword': password, 'newPassword': newPassword},
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }
}
