import 'package:flutter/material.dart';
import 'package:tournament_app/core/get_it_config.dart';
import 'core/app_route.dart';

void main() {
  configureGetItApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Tournament APP',
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      // theme: ThemeData.dark(), //aca va el tema de la aplicacion
    );
  }
}
