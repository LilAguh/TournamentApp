import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login simple'),
        backgroundColor: Colors.blue[400],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.isSucess) {
              // Este es el caso de login exitoso
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

              // ignore: invalid_use_of_visible_for_testing_member
              context.read<AuthBloc>().emit(state.copyWith(isSucess: false));
            }

            if (state.errorMessage != null) {
              _passwordController.clear();
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return TextField(
                    controller: _aliasController,
                    onChanged:
                        (value) => context.read<AuthBloc>().add(
                          AuthAliasChanged(value),
                        ),
                    decoration: InputDecoration(
                      labelText: 'Alias',
                      border: const OutlineInputBorder(),
                      errorText:
                          state.alias.isEmpty && state.errorMessage != null
                              ? 'Alias obligatorio'
                              : null,
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),

              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return TextField(
                    controller: _passwordController,
                    onChanged:
                        (value) => context.read<AuthBloc>().add(
                          AuthPasswordChanged(value),
                        ),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: const OutlineInputBorder(),
                      errorText:
                          state.password.isEmpty && state.errorMessage != null
                              ? 'Password obligatorio'
                              : null,
                    ),
                    obscureText: true,
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

                  // if (state.errorMessage != null) {
                  //   return Padding(
                  //     padding: const EdgeInsets.symmetric(vertical: 16),
                  //     child: Text(
                  //       state.errorMessage!,
                  //       style: const TextStyle(color: Colors.red),
                  //     ),
                  //   );
                  // }
                  return const SizedBox.shrink();
                },
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<AuthBloc>().add(AuthSubmitted());
                },
                child: Text('Iniciar Sesion'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
