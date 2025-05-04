import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ActivateAccount extends StatelessWidget {
  const ActivateAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('activate account'),
        backgroundColor: Colors.blue[400],
      ),

      // Centrado
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('ACA SE HACE LA AUTORIZACION CON EL CODIGO DEL MAIL'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  context.go('/new-user-welcome');
                },
                child: const Text('Continuar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
