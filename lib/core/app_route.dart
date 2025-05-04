import 'package:tournament_app/features/auth/presentation/page/activate_account_screen.dart';
import 'package:tournament_app/features/auth/presentation/page/auth_welcome_screen.dart';
import 'package:tournament_app/features/auth/presentation/page/login_screen.dart';
import 'package:tournament_app/features/auth/presentation/page/new_user_welcome_screen.dart';
import 'package:tournament_app/features/auth/presentation/page/register_email_screen.dart';
import 'package:tournament_app/features/auth/presentation/page/register_method_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/auth-location',

  routes: [
    GoRoute(
      name: 'auth welcome',
      path: '/auth-location',
      builder: (context, state) => const AuthWelcome(),
    ),
    GoRoute(
      name: 'login screen',
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      name: 'register method',
      path: '/register-method',
      builder: (context, state) => const RegisterMethod(),
    ),
    GoRoute(
      name: 'new user welcome',
      path: '/new-user-welcome',
      builder: (context, state) => const NewUserWelcome(),
    ),
    GoRoute(
      name: 'register email',
      path: '/register-email',
      builder: (context, state) => const RegisterEmail(),
    ),
    GoRoute(
      name: 'activate account',
      path: '/activate-account',
      builder: (context, state) => const ActivateAccount(),
    ),
  ],
);
