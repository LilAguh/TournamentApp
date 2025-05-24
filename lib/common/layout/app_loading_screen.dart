import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tournament_app/features/country/presentation/bloc/country_bloc.dart';
import 'package:tournament_app/features/country/presentation/bloc/country_event.dart';
import 'package:tournament_app/features/country/presentation/bloc/country_state.dart';

class AppLoadingScreen extends StatefulWidget {
  const AppLoadingScreen({super.key});

  @override
  State<AppLoadingScreen> createState() => _AppLoadingScreenState();
}

class _AppLoadingScreenState extends State<AppLoadingScreen> {
  @override
  @override
  void initState() {
    super.initState();
    context.read<CountryBloc>().add(GetCountryRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CountryBloc, CountryState>(
      listener: (context, state) {
        if (state is CountrySuccess) {
          // ✅ Cuando se cargan los países, redirigís
          context.go('/auth-welcome');
        } else if (state is CountryFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(), // ⏳ Loading visual
        ),
      ),
    );
  }
}
