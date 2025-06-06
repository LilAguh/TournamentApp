import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tournament_app/common/layout/framed_background.dart';
import 'package:tournament_app/common/layout/noise_background.dart';
import 'package:tournament_app/common/widgets/gothic_button.dart';
import 'package:tournament_app/features/auth/presentation/bloc/auth_bloc.dart';

class ActivateAccountScreen extends StatefulWidget {
  const ActivateAccountScreen({super.key});

  @override
  State<ActivateAccountScreen> createState() => _ActivateAccountScreenState();
}

class _ActivateAccountScreenState extends State<ActivateAccountScreen> {
  String _code = '';

  void _onConfirmPressed() {
    if (_code == "12345") {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Código correcto")));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Código incorrecto")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FramedBackground(
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Registro',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFD6C8B0),
                    fontSize: 70,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Classicloud',
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'Ingresá el código enviado por correo',
                  style: TextStyle(fontSize: 20, color: Color(0xFFD6C8B0)),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: PinCodeTextField(
                    appContext: context,
                    length: 5,
                    onChanged: (value) => setState(() => _code = value),
                    keyboardType: TextInputType.number,
                    autoFocus: true,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(12),
                      fieldHeight: 52,
                      fieldWidth: 45,
                      activeFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                      selectedFillColor: Colors.grey[100],
                      inactiveColor: Colors.grey[400]!,
                      activeColor: Colors.blueAccent,
                      selectedColor: Colors.blue,
                    ),
                    enableActiveFill: true,
                  ),
                ),
                const SizedBox(height: 24),
                GothicButton(
                  text: 'Activar cuenta',
                  width: MediaQuery.of(context).size.width * 0.7,
                  onPressed: _code.length == 5 ? _onConfirmPressed : null,
                ),
              ],
            ),
          ),
          const Positioned.fill(
            child: IgnorePointer(child: NoiseBackground(opacity: .05)),
          ),
        ],
      ),
    );
  }
}
