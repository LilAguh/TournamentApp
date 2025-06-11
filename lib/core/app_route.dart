import 'package:tournament_app/common/layout/startup_screen.dart';
import 'package:tournament_app/features/deck/presentation/page/deck_screen.dart';
import 'package:tournament_app/features/home/presentation/page/home_screen.dart';
import 'package:tournament_app/features/match/presentation/page/match_screen.dart';
import 'package:tournament_app/features/profile/presentation/page/profile_screen.dart';
import 'package:tournament_app/features/tournament/presentation/page/tournament_screen.dart';

import 'package:tournament_app/common/layout/main_navigation_shell.dart';

import 'package:tournament_app/features/auth/presentation/page/activate_account_screen.dart';
import 'package:tournament_app/features/auth/presentation/page/auth_welcome_screen.dart';
import 'package:tournament_app/features/auth/presentation/page/login_screen.dart';
import 'package:tournament_app/features/auth/presentation/page/new_user_welcome_screen.dart';
import 'package:tournament_app/features/auth/presentation/page/register_email_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',

  routes: [
    GoRoute(path: '/', builder: (context, state) => const StartupScreen()),
    GoRoute(
      name: 'auth welcome',
      path: '/auth-welcome',
      builder: (context, state) => const AuthWelcome(),
    ),
    GoRoute(
      name: 'login screen',
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      name: 'new user welcome',
      path: '/new-user-welcome',
      builder: (context, state) => const NewUserWelcome(),
    ),
    GoRoute(
      name: 'register email',
      path: '/register-email',
      builder: (context, state) => RegisterEmailScreen(),
    ),
    GoRoute(
      name: 'activate account',
      path: '/activate-account',
      builder: (context, state) => const ActivateAccountScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) => MainNavigationShell(child: child),
      routes: [
        GoRoute(name: 'home', path: '/home', builder: (_, __) => const Home()),
        GoRoute(name: 'deck', path: '/deck', builder: (_, __) => const Deck()),
        GoRoute(
          name: 'match',
          path: '/match',
          builder: (_, __) => const Match(),
        ),
        GoRoute(
          name: 'tournaments',
          path: '/tournaments',
          builder: (_, __) => const Tournament(),
        ),
        GoRoute(
          name: 'profile',
          path: '/profile',
          builder: (_, __) => const ProfileScreen(),
        ),
      ],
    ),
  ],
);
