import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Match extends StatelessWidget {
  const Match({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MATCH'),
        backgroundColor: Colors.green[400],
      ),
    );
  }
}
