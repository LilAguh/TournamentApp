import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tournament_app/common/layout/framed_background.dart';
import 'package:tournament_app/common/layout/noise_background.dart';
import 'package:tournament_app/common/widgets/gothic_button.dart';
import 'package:tournament_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:tournament_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:tournament_app/features/auth/presentation/bloc/auth_state.dart';

class ActivateAccountScreen extends StatefulWidget {
  const ActivateAccountScreen({super.key});

  @override
  State<ActivateAccountScreen> createState() => _ActivateAccountScreenState();
}

class _ActivateAccountScreenState extends State<ActivateAccountScreen> {
  String _code = '';

  void _onConfirmPressed() async {
    if (_code == "12345") {
      final prefs = await SharedPreferences.getInstance();
      final alias = prefs.getString('tempAlias');
      final password = prefs.getString('tempPassword');

      if (alias != null && password != null) {
        final bloc = context.read<AuthBloc>();
        bloc.add(AuthAliasChanged(alias));
        bloc.add(AuthPasswordChanged(password));
        bloc.add(AuthSubmitted());
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Error: No se encontraron credenciales"),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Código incorrecto")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen:
          (previous, current) =>
              previous.isSucess != current.isSucess ||
              previous.errorMessage != current.errorMessage,
      listener: (context, state) async {
        if (state.isSucess) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.remove('tempAlias');
          await prefs.remove('tempPassword');

          context.go('/home'); // Ruta de destino luego del login
        }

        if (state.errorMessage != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }
      },
      child: FramedBackground(
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
                    height: 52,
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
      ),
    );
  }
}
