import 'package:tournament_app/features/auth/domain/entities/user.dart';

// abstract class AuthState {}

// class AuthInitial extends AuthState {}

// class AuthLoading extends AuthState {}

// class AuthSuccess extends AuthState {
//   final User user;
//   AuthSuccess(this.user);
// }

// class AuthFailure extends AuthState {
//   final String message;
//   AuthFailure(this.message);
// }

class AuthState {
  final String alias;
  final String password;
  final bool isLoading;
  final String? errorMessage;
  final bool isSucess;

  const AuthState({
    required this.alias,
    required this.password,
    this.isLoading = false,
    this.errorMessage,
    this.isSucess = false,
  });

  factory AuthState.initial() => const AuthState(alias: '', password: '');

  AuthState copyWith({
    String? alias,
    String? password,
    bool? isLoading,
    String? errorMessage,
    bool? isSucess,
  }) {
    return AuthState(
      alias: alias ?? this.alias,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      isSucess: isSucess ?? this.isSucess,
    );
  }
}
