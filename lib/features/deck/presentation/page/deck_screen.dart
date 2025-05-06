import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Deck extends StatelessWidget {
  const Deck({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DECK'),
        backgroundColor: Colors.green[400],
      ),
    );
  }
}
