import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:tournament_app/common/layout/framed_background.dart';
import 'package:tournament_app/common/layout/noise_background.dart';
import 'package:tournament_app/common/widgets/gothic_button.dart';
import 'package:tournament_app/core/services/user_location_service.dart';

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
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: FramedBackground(
        child: Stack(
          children: [
            Center(
              child:
                  isLoading
                      ? const CircularProgressIndicator()
                      : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Paw of Fate',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFFD6C8B0),
                              fontSize: 100, // Reducido de 100
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Classicloud',
                            ),
                          ),
                          const SizedBox(height: 8), // Reducido de 10
                          const Text(
                            'Within your paws, the tarot whispers fate.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFFD6C8B0),
                              fontSize: 24, // Reducido de 30
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Minion',
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ), // Aumentado para mejor espaciado
                          GothicButton(
                            text: 'Iniciar Sesión',
                            width:
                                MediaQuery.of(context).size.width *
                                0.7, // Ancho relativo
                            onPressed: () => context.go('/login'),
                          ),
                          const SizedBox(height: 16),
                          GothicButton(
                            text: 'Crear nuevo usuario',
                            width:
                                MediaQuery.of(context).size.width *
                                0.7, // Ancho relativo
                            onPressed: () async {
                              setState(() => isLoading = true);

                              final country =
                                  await UserLocationService()
                                      .getBestAvailableCountry();

                              if (country != null) {
                                countryCode = country.$1;
                                countryName = country.$2;

                                await UserLocationService()
                                    .saveCountryAndCodeToPrefs(
                                      countryCode!,
                                      countryName!,
                                    );

                                Future.microtask(() {
                                  context.go('/register-email');
                                });
                              }

                              setState(() {
                                isLoading = false;
                                isDataLoaded = true;
                              });
                            },
                          ),
                        ],
                      ),
            ),
            const Positioned.fill(
              child: IgnorePointer(
                child: NoiseBackground(opacity: .05),
              ), // Reducida opacidad
            ),
          ],
        ),
      ),
    );
  }
}
