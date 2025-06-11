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
  final bool isLoading;
  final bool isSucess;
  final String? errorMessage;
  final String alias;
  final String password;

  const AuthState({
    required this.isLoading,
    required this.isSucess,
    required this.errorMessage,
    required this.alias,
    required this.password,
  });

  factory AuthState.initial() {
    return const AuthState(
      isLoading: false,
      isSucess: false,
      errorMessage: null,
      alias: '',
      password: '',
    );
  }

  AuthState copyWith({
    bool? isLoading,
    bool? isSucess,
    String? errorMessage,
    String? alias,
    String? password,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isSucess: isSucess ?? this.isSucess,
      errorMessage: errorMessage,
      alias: alias ?? this.alias,
      password: password ?? this.password,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isSucess,
    errorMessage,
    alias,
    password,
  ];
}
