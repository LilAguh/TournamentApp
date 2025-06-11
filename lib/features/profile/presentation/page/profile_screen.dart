import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tournament_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:tournament_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:tournament_app/features/auth/presentation/bloc/auth_state.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  Future<Map<String, dynamic>> _getProfileData() async {
    final prefs = await SharedPreferences.getInstance();

    return {
      'id': prefs.getInt('userId') ?? 0,
      'alias': prefs.getString('profile_alias') ?? '',
      'avatarUrl':
          prefs.getString('profile_avatarUrl') ??
          'https://www.gravatar.com/avatar/?d=mp',
    };
  }

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // 🔥 Borra todo
    context.read<AuthBloc>().add(AuthLogoutRequested());
    print('se elimino la sesion del usuario');
    context.go('/auth-welcome');
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        // Si necesitás manejar estado post logout, podés hacerlo acá
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mi Perfil'),
          backgroundColor: Colors.green[400],
        ),
        body: FutureBuilder<Map<String, dynamic>>(
          future: _getProfileData(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final data = snapshot.data!;
            final id = data['id'];
            final alias = data['alias'];
            final avatarUrl = data['avatarUrl'];

            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(avatarUrl),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      alias,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'ID: $id',
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () => _logout(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[400],
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: const Text('Cerrar sesión'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
