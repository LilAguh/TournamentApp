import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tournament_app/features/country/presentation/bloc/country_bloc.dart';
import 'package:tournament_app/features/country/presentation/bloc/country_event.dart';
import 'package:tournament_app/features/country/presentation/bloc/country_state.dart';

class AuthWelcome extends StatefulWidget {
  const AuthWelcome({super.key});

  @override
  State<AuthWelcome> createState() => _AuthWelcome();
}

class _AuthWelcome extends State<AuthWelcome> {
  @override
  void initState() {
    super.initState();
    // context.read<CountryBloc>().add(GetCountryRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('auth welcome'),
        backgroundColor: Colors.blue[400],
      ),

      // Centrado
      body: Center(
        child: BlocListener<CountryBloc, CountryState>(
          listener: (context, state) {
            if (state is CountrySuccess) {
              Future.microtask(() {
                context.go('/register-method');
              });
            }
          },
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
                    final bloc = context.read<CountryBloc>();
                    bloc.add(GetCountryRequested());
                  },
                  child: const Text('Crear nuevo usuario'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
