import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterEmail extends StatelessWidget {
  const RegisterEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Email'),
        backgroundColor: Colors.blue[400],
      ),

      // Centrado
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const TextField(decoration: InputDecoration(labelText: 'Nombre')),
              const SizedBox(height: 16),
              const TextField(
                decoration: InputDecoration(labelText: 'Apellido'),
              ),
              const SizedBox(height: 16),
              const TextField(decoration: InputDecoration(labelText: 'Alias')),
              const SizedBox(height: 16),
              const TextField(decoration: InputDecoration(labelText: 'Email')),
              const SizedBox(height: 16),
              const TextField(
                decoration: InputDecoration(labelText: 'Repetir Email'),
              ),
              const SizedBox(height: 16),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(labelText: 'Contraseña'),
              ),
              const SizedBox(height: 24),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(labelText: 'Repetir Contraseña'),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  context.go('/activate-account');
                },
                child: const Text('Ingresar'),
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
