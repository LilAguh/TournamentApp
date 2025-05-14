import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tournament_app/core/get_it_config.dart';
import 'package:tournament_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'core/app_route.dart';

void main() {
  configureGetItApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => GetIt.instance<AuthBloc>()),
      ],
      child: MaterialApp.router(
        title: 'Tournament APP',
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
        // theme: ThemeData.dark(), //aca va el tema de la aplicacion
      ),
    );
  }
}
