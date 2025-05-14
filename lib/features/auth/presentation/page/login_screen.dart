import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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

  void _submitLogin() {
    final alias = _aliasController.text.trim();
    final password = _passwordController.text.trim();

    if (alias.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Alias y contraseña son obligatorios')),
      );
      return;
    }

    context.read<AuthBloc>().add(
      LoginRequested(alias: alias, password: password),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          print('✅ Login exitoso:');
          print('ID: ${state.user.id}');
          print('Alias: ${state.user.alias}');
          print('Email: ${state.user.email}');
          print('Rol: ${state.user.role}');
          context.goNamed('home');
        } else if (state is AuthFailure) {
          print('❌ Error al iniciar sesión: ${state.message}');
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
          backgroundColor: Colors.blue[400],
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _aliasController,
                  decoration: const InputDecoration(labelText: 'Alias'),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Contraseña'),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _submitLogin,
                  child: const Text('Ingresar'),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    context.go('/register-method');
                  },
                  child: const Text('¿No tenés cuenta? Registrate'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
