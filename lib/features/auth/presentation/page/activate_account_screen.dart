import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tournament_app/common/layout/framed_background.dart';
import 'package:tournament_app/common/layout/noise_background.dart';
import 'package:tournament_app/common/widgets/gothic_button.dart';

class ActivateAccountScreen extends StatefulWidget {
  const ActivateAccountScreen({super.key});

  @override
  State<ActivateAccountScreen> createState() => _ActivateAccountScreenState();
}

class _ActivateAccountScreenState extends State<ActivateAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return FramedBackground(
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('ACA SE HACE LA AUTORIZACION CON EL CODIGO DEL MAIL'),
                const SizedBox(height: 16),
                GothicButton(
                  text: 'Continuar',
                  width:
                      MediaQuery.of(context).size.width * 0.7, // Ancho relativo
                  onPressed: () => context.go(''),
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
    );
  }
}
