import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tournament_app/core/get_it_config.dart';
import 'package:tournament_app/features/auth/config/auth_config.dart';
import 'package:tournament_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:tournament_app/features/auth/presentation/register/bloc/register_bloc.dart';
import 'package:tournament_app/features/card/presentation/bloc/card_bloc.dart';
import 'package:tournament_app/features/country/presentation/bloc/country_bloc.dart';
import 'package:tournament_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'core/app_route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureGetItApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider<AuthBloc>(create: (_) => GetIt.instance<AuthBloc>()),
        BlocProvider(create: (_) => sl<AuthBloc>()),
        BlocProvider(create: (_) => sl<CountryBloc>()),
        BlocProvider(create: (_) => sl<RegisterBloc>()),
        BlocProvider(create: (_) => sl<ProfileBloc>()),
        BlocProvider(create: (_) => sl<CardBloc>()),
      ],
      child: MaterialApp.router(
        title: 'Tournament APP',
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
        // theme: ThemeData.dark(), //aca va el tema de la aplicacion
        theme: ThemeData(fontFamily: 'Minion'),
      ),
    );
  }
}
