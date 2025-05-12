import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:tournament_app/features/auth/domain/use_cases/login_use_cases.dart';
import 'package:tournament_app/core/error/failure.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _aliasController = TextEditingController();
  final _passwordController = TextEditingController();
  late LoginUseCase loginUseCase;

  @override
  void initState() {
    super.initState();
    loginUseCase = GetIt.instance.get<LoginUseCase>();
  }

  @override
  void dispose() {
    _aliasController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final alias = _aliasController.text.trim();
    final password = _passwordController.text.trim();

    if (alias.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Alias y contraseña son obligatorios')),
      );
      return;
    }

    final result = await loginUseCase.call(alias: alias, password: password);

    result.fold(
      (Failure failure) {
        print('❌ Error al iniciar sesión: ${failure.message}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(failure.message ?? 'Error al iniciar sesión')),
        );
      },
      (user) {
        print('✅ Login exitoso:');
        print('ID: ${user.id}');
        print('Alias: ${user.alias}');
        print('Email: ${user.email}');
        print('Rol: ${user.role}');
        context.goNamed('home');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                onPressed: _handleLogin,
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
    );
  }
}
