import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Tournament extends StatelessWidget {
  const Tournament({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TOURNAMENTS'),
        backgroundColor: Colors.green[400],
      ),
    );
  }
}
