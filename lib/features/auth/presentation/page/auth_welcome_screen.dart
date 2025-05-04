import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthWelcome extends StatelessWidget {
  const AuthWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('auth welcome'),
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
                  context.go('/login');
                },
                child: const Text('Iniciar sesion'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  context.go('/register-method');
                },
                child: const Text('Crear nuevo usuario'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
