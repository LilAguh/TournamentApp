import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tournament_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:tournament_app/features/auth/presentation/bloc/auth_state.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    // final alias = context.select<AuthBloc, String?>((bloc) {
    //   final state = bloc.state;
    //   if (state is AuthSuccess) {
    //     return state.user.alias;
    //   }
    //   return null;
    // });

    return Scaffold(
      appBar: AppBar(
        title: const Text('HOME'),
        backgroundColor: Colors.green[400],
      ),
      // body: Center(child: Text('¡Bienvenido, ${alias ?? "invitado"}!')),
    );
  }
}
