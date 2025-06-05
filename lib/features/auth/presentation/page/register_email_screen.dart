import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import 'package:tournament_app/common/widgets/gothic_text_field.dart';
import 'package:tournament_app/common/widgets/gothic_button.dart';
import 'package:tournament_app/common/layout/framed_background.dart';
import 'package:tournament_app/common/layout/noise_background.dart';

import '../register/bloc/register_bloc.dart';
import '../register/bloc/register_event.dart';
import '../register/bloc/register_state.dart';

class RegisterEmailScreen extends StatefulWidget {
  const RegisterEmailScreen({super.key});

  @override
  State<RegisterEmailScreen> createState() => _RegisterEmailScreenState();
}

class _RegisterEmailScreenState extends State<RegisterEmailScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _aliasController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordRepeatController = TextEditingController();
  bool _termsAccepted = false;

  Widget _socialIconButton(String assetPath, {required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(100),
      child: Container(
        width: 48,
        height: 48,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFF1C1C1C),
          border: Border.all(color: const Color(0xFFD6C8B0)),
        ),
        child: SvgPicture.asset(
          assetPath,
          width: 24,
          height: 24,
          colorFilter: const ColorFilter.mode(
            Color(0xFFD6C8B0),
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }

  void _clearForm() {
    _firstNameController.clear();
    _lastNameController.clear();
    _aliasController.clear();
    _emailController.clear();
    _passwordController.clear();
    _passwordRepeatController.clear();
    setState(() => _termsAccepted = false);

    final bloc = context.read<RegisterBloc>();
    bloc.add(RegisterFirstNameChanged(''));
    bloc.add(RegisterLastNameChanged(''));
    bloc.add(RegisterAliasChanged(''));
    bloc.add(RegisterEmailChanged(''));
    bloc.add(RegisterPasswordChanged(''));
    bloc.add(RegisterPasswordRepeatChanged(''));
  }

  void _showTermsDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (ctx) => AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Términos y Condiciones',
                  style: TextStyle(
                    color: Color(0xFFD6C8B0),
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(ctx).pop(),
                ),
              ],
            ),
            content: const SingleChildScrollView(
              child: Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
                'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('Aceptar'),
              ),
            ],
          ),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _aliasController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordRepeatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: FramedBackground(
        child: Stack(
          children: [
            BlocListener<RegisterBloc, RegisterState>(
              listenWhen:
                  (previous, current) =>
                      previous.isSuccess != current.isSuccess ||
                      previous.errorMessage != current.errorMessage,
              listener: (context, state) {
                if (state.isSuccess) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Registro exitoso')),
                    );
                    _clearForm();
                    context.read<RegisterBloc>().add(RegisterResetSuccess());
                    context.go('/activate-account');
                  });
                }

                if (state.errorMessage != null) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.errorMessage!)),
                    );
                  });
                }
              },
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // const Text(
                      //   'Registro',
                      //   textAlign: TextAlign.center,
                      //   style: TextStyle(
                      //     color: Color(0xFFD6C8B0),
                      //     fontSize: 50,
                      //     fontWeight: FontWeight.bold,
                      //     fontFamily: 'Classicloud',
                      //   ),
                      // ),
                      const SizedBox(height: 30),
                      BlocBuilder<RegisterBloc, RegisterState>(
                        builder: (context, state) {
                          final isFormValid =
                              state.isFirstNameValid &&
                              state.isLastNameValid &&
                              state.isAliasValid &&
                              state.isEmailValid &&
                              state.isPasswordValid &&
                              state.isPasswordRepeatValid &&
                              _termsAccepted;

                          return Column(
                            children: [
                              GothicTextField(
                                label: 'Nombre',
                                controller: _firstNameController,
                                onChanged:
                                    (value) => context.read<RegisterBloc>().add(
                                      RegisterFirstNameChanged(value),
                                    ),
                                errorText:
                                    state.firstName.isEmpty ||
                                            state.isFirstNameValid
                                        ? null
                                        : 'Campo requerido',
                                isValid: state.isFirstNameValid,
                              ),
                              const SizedBox(height: 16),
                              GothicTextField(
                                label: 'Apellido',
                                controller: _lastNameController,
                                onChanged:
                                    (value) => context.read<RegisterBloc>().add(
                                      RegisterLastNameChanged(value),
                                    ),
                                errorText:
                                    state.lastName.isEmpty ||
                                            state.isLastNameValid
                                        ? null
                                        : 'Campo requerido',
                                isValid: state.isLastNameValid,
                              ),
                              const SizedBox(height: 16),
                              GothicTextField(
                                label: 'Alias',
                                controller: _aliasController,
                                onChanged:
                                    (value) => context.read<RegisterBloc>().add(
                                      RegisterAliasChanged(value),
                                    ),
                                errorText:
                                    state.alias.isEmpty || state.isAliasValid
                                        ? null
                                        : 'Campo requerido',
                                isValid: state.isAliasValid,
                              ),
                              const SizedBox(height: 16),
                              GothicTextField(
                                label: 'Email',
                                controller: _emailController,
                                onChanged:
                                    (value) => context.read<RegisterBloc>().add(
                                      RegisterEmailChanged(value),
                                    ),
                                errorText:
                                    state.email.isEmpty || state.isEmailValid
                                        ? null
                                        : 'Email inválido',
                                isValid: state.isEmailValid,
                              ),
                              const SizedBox(height: 16),
                              GothicTextField(
                                label: 'Contraseña',
                                obscureText: true,
                                controller: _passwordController,
                                onChanged:
                                    (value) => context.read<RegisterBloc>().add(
                                      RegisterPasswordChanged(value),
                                    ),
                                errorText:
                                    state.password.isEmpty ||
                                            state.isPasswordValid
                                        ? null
                                        : 'Min. 8 caracteres, 1 mayúscula, 1 número, 1 símbolo',
                                isValid: state.isPasswordValid,
                              ),
                              const SizedBox(height: 16),
                              GothicTextField(
                                label: 'Repetir contraseña',
                                obscureText: true,
                                controller: _passwordRepeatController,
                                onChanged:
                                    (value) => context.read<RegisterBloc>().add(
                                      RegisterPasswordRepeatChanged(value),
                                    ),
                                errorText:
                                    state.passwordRepeat.isEmpty ||
                                            state.isPasswordRepeatValid
                                        ? null
                                        : 'Las contraseñas no coinciden',
                                isValid: state.isPasswordRepeatValid,
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Checkbox(
                                    value: _termsAccepted,
                                    onChanged:
                                        (value) => setState(
                                          () => _termsAccepted = value ?? false,
                                        ),
                                    activeColor: Colors.green,
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: _showTermsDialog,
                                      child: const Text.rich(
                                        TextSpan(
                                          text: 'Acepto los ',
                                          style: TextStyle(
                                            color: Color(0xFFD6C8B0),
                                            fontSize: 14,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: 'términos y condiciones',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              if (state.isLoading)
                                const Center(child: CircularProgressIndicator())
                              else
                                GothicButton(
                                  text: 'Registrarse',
                                  height: 52,
                                  onPressed:
                                      isFormValid
                                          ? () => context
                                              .read<RegisterBloc>()
                                              .add(RegisterSubmitted())
                                          : null,
                                ),
                              const SizedBox(height: 10),
                              Divider(
                                color: Color(0xFF888888),
                                thickness: 1,
                                indent: 40,
                                endIndent: 40,
                              ),
                              const SizedBox(height: 6),
                              const Text(
                                'O registrate con:',
                                style: TextStyle(
                                  color: Color(0xFFD6C8B0),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _socialIconButton(
                                    'assets/icons/google.svg',
                                    onTap: () {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'No disponible momentáneamente',
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(width: 24),
                                  _socialIconButton(
                                    'assets/icons/facebook.svg',
                                    onTap: () {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'No disponible momentáneamente',
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(width: 24),
                                  _socialIconButton(
                                    'assets/icons/apple.svg',
                                    onTap: () {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'No disponible momentáneamente',
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              TextButton(
                                onPressed: () => context.go('/login'),
                                child: const Text(
                                  '¿Ya tenés una cuenta? Iniciar sesión',
                                  style: TextStyle(
                                    color: Color(0xFFD6C8B0),
                                    fontSize: 14,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
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
