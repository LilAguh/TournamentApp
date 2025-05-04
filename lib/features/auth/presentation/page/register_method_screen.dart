import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterMethod extends StatelessWidget {
  const RegisterMethod({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('register  method'),
        backgroundColor: Colors.blue[400],
      ),

      // Centrado
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  context.go('/register-email');
                },
                child: const Text('Registrarse con Email'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  context.go('/new-user-welcome');
                },
                child: const Text('Registrarse con Facebook'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  context.go('/new-user-welcome');
                },
                child: const Text('Registrarse con Google'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  context.go('/new-user-welcome');
                },
                child: const Text('Registrarse con Apple'),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  context.go('/login');
                },
                child: const Text(
                  '¿Ya tenes cuenta? Inicia sesion con tu cuenta.',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
