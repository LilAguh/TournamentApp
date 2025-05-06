import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NewUserWelcome extends StatelessWidget {
  const NewUserWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('new user welcome'),
        backgroundColor: Colors.blue[400],
      ),

      // Centrado
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Bienvenido'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  context.goNamed('home');
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
