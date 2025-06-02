import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tournament_app/core/error/failure.dart';
import 'package:tournament_app/features/auth/domain/entities/user.dart';
import 'package:tournament_app/features/auth/domain/repository/users_repository.dart';

class RegisterUseCase {
  final UsersRepository repository;

  RegisterUseCase({required this.repository});

  Future<Either<Failure, User>> call({
    required String firstName,
    required String lastName,
    required String alias,
    required String email,
    required String password,
    required String countryCode,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final countryCode = prefs.getString('user_country_code') ?? 'BR';

    return await repository.register(
      firstName: firstName,
      lastName: lastName,
      alias: alias,
      email: email,
      password: password,
      countryCode: countryCode,
    );
  }
}
