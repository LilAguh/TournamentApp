import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  @override
  void dispose() {
    _aliasController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: FramedBackground(
        child: Stack(
          children: [
            Center(
              child: BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state.isSucess) {
                    _aliasController.clear();
                    _passwordController.clear();
                    Future.microtask(() {
                      context.goNamed('home');
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Login Exitoso'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    // Reset flag
                    context.read<AuthBloc>().emit(
                      state.copyWith(isSucess: false),
                    );
                  }

                  if (state.errorMessage != null) {
                    _passwordController.clear();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.errorMessage!)),
                    );
                  }
                },
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
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
                        const SizedBox(height: 10),
                        const Text(
                          'Ni idea que poner, pero completa los datos',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFD6C8B0),
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Minion',
                          ),
                        ),
                        const SizedBox(height: 40),
                        BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            return GothicTextField(
                              label: 'Alias',
                              fieldName: 'alias',
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
                        const SizedBox(height: 20),
                        BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            return GothicTextField(
                              label: 'Password',
                              fieldName: 'password',
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
                        const SizedBox(height: 40),
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
                              onPressed: () {
                                context.read<AuthBloc>().add(AuthSubmitted());
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Positioned.fill(
              child: IgnorePointer(child: NoiseBackground(opacity: .1)),
            ),
          ],
        ),
      ),
    );
  }
}
