import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tournament_app/core/services/user_location_service.dart';
import 'package:tournament_app/features/country/presentation/bloc/country_bloc.dart';
import 'package:tournament_app/features/country/presentation/bloc/country_state.dart';

class AuthWelcome extends StatefulWidget {
  const AuthWelcome({super.key});

  @override
  State<AuthWelcome> createState() => _AuthWelcome();
}

class _AuthWelcome extends State<AuthWelcome> {
  bool isDataLoaded = false;
  bool isLoading = false;
  String? countryCode;
  String? countryName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('auth welcome'),
        backgroundColor: Colors.blue[400],
      ),
      body: Center(
        child:
            isLoading
                ? const CircularProgressIndicator()
                : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => context.go('/login'),
                      child: const Text('Iniciar sesión'),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        setState(() => isLoading = true);

                        final country =
                            await UserLocationService()
                                .getBestAvailableCountry();

                        if (country != null) {
                          countryCode = country.$1;
                          countryName = country.$2;

                          await UserLocationService().saveCountryAndCodeToPrefs(
                            countryCode!,
                            countryName!,
                          );
                          Future.microtask(() {
                            context.go('/register-method');
                          });
                        }

                        setState(() {
                          isLoading = false;
                          isDataLoaded = true;
                        });
                      },
                      child: const Text('Crear nuevo usuario'),
                    ),
                  ],
                ),
      ),
    );
  }
}
