import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tournament_app/common/layout/framed_background.dart';
import 'package:tournament_app/common/layout/noise_background.dart';
import 'package:tournament_app/common/widgets/gothic_button.dart';
import 'package:tournament_app/common/widgets/gothic_text_field.dart';
import 'package:tournament_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:tournament_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:tournament_app/features/auth/presentation/bloc/auth_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _aliasController = TextEditingController();
  final _passwordController = TextEditingController();

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

  @override
  void dispose() {
    _aliasController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FramedBackground(
      child: Stack(
        children: [
          Center(
            child: BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state.isSucess) {
                  _aliasController.clear();
                  _passwordController.clear();
                  Future.microtask(() => context.goNamed('home'));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Login Exitoso'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  context.read<AuthBloc>().emit(
                    state.copyWith(isSucess: false),
                  );
                }

                if (state.errorMessage != null) {
                  _passwordController.clear();
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(34.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Login',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFD6C8B0),
                        fontSize: 70,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Classicloud',
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Ni idea que poner, pero completa los datos',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFD6C8B0),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Minion',
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          return GothicTextField(
                            label: 'Alias',
                            controller: _aliasController,
                            onChanged:
                                (value) => context.read<AuthBloc>().add(
                                  AuthAliasChanged(value),
                                ),
                            errorText:
                                state.alias.isEmpty &&
                                        state.errorMessage != null
                                    ? 'Alias obligatorio'
                                    : null,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          return GothicTextField(
                            label: 'Password',
                            controller: _passwordController,
                            onChanged:
                                (value) => context.read<AuthBloc>().add(
                                  AuthPasswordChanged(value),
                                ),
                            errorText:
                                state.password.isEmpty &&
                                        state.errorMessage != null
                                    ? 'Password obligatorio'
                                    : null,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if (state.isLoading) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: CircularProgressIndicator(),
                          );
                        }
                        return GothicButton(
                          text: 'Iniciar Sesión',
                          width: MediaQuery.of(context).size.width * 0.7,
                          onPressed: () {
                            context.read<AuthBloc>().add(AuthSubmitted());
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 6),
                    const SizedBox(height: 10),
                    Divider(
                      color: Color(0xFF888888),
                      thickness: 1,
                      indent: 40,
                      endIndent: 40,
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'O inicia sesion con:',
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
                            // TODO: lógica para Google
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('No disponible momentáneamente'),
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 24),
                        _socialIconButton(
                          'assets/icons/facebook.svg',
                          onTap: () {
                            // TODO: lógica para Facebook
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('No disponible momentáneamente'),
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 24),
                        _socialIconButton(
                          'assets/icons/apple.svg',
                          onTap: () {
                            // TODO: lógica para Twitter
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('No disponible momentáneamente'),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () => context.go('/register-email'),
                      child: const Text(
                        '¿No tenés una cuenta? Registrate',
                        style: TextStyle(
                          color: Color(0xFFD6C8B0),
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                        ),
                      ),
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
    );
  }
}
