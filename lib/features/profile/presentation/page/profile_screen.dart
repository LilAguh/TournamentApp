import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';
import 'package:tournament_app/common/widgets/gothic_button.dart';
import 'package:tournament_app/common/layout/noise_background.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<Map<String, dynamic>> _getProfileData() async {
    final prefs = await SharedPreferences.getInstance();

    return {
      'alias': prefs.getString('profile_alias') ?? 'arcane_cat',
      'email': prefs.getString('profile_email') ?? 'arcanecat@example.com',
      'avatarUrl':
          prefs.getString('profile_avatarUrl') ??
          'https://www.gravatar.com/avatar/?d=mp',
    };
  }

  void _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    context.go('/auth-welcome');
  }

  Widget _statTile(IconData icon, int value) {
    return Column(
      children: [
        Icon(icon, size: 30, color: Colors.grey[200]),
        const SizedBox(height: 4),
        Text(
          value.toString(),
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // ✅ fondo negro sólido
      body: Stack(
        children: [
          const NoiseBackground(opacity: 1), // 🌌 fondo
          FutureBuilder<Map<String, dynamic>>(
            future: _getProfileData(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final alias = snapshot.data!['alias'];
              final email = snapshot.data!['email'];
              final avatarUrl = snapshot.data!['avatarUrl'];

              return SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 40,
                  ),
                  child: Column(
                    children: [
                      // ✅ Avatar cuadrado grande
                      Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: NetworkImage(avatarUrl),
                            fit: BoxFit.cover,
                          ),
                          border: Border.all(color: Colors.amber, width: 2),
                        ),
                      ),
                      const SizedBox(height: 20),

                      Text(
                        alias,
                        style: const TextStyle(
                          fontSize: 22,
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(email, style: TextStyle(color: Colors.grey[400])),
                      const SizedBox(height: 30),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _statTile(Icons.layers, 84),
                          _statTile(Icons.shield, 26),
                          _statTile(Icons.auto_awesome, 1775),
                          _statTile(Icons.emoji_events, 12),
                        ],
                      ),

                      const SizedBox(height: 30),
                      const Divider(
                        thickness: 1.2,
                        color: Colors.grey,
                        indent: 20,
                        endIndent: 20,
                      ),
                      const SizedBox(height: 20),

                      GothicButton(
                        text: 'Change Password',
                        onPressed: () {
                          // TODO
                        },
                      ),
                      GothicButton(
                        text: 'Deactivate Account',
                        onPressed: () {
                          // TODO
                        },
                      ),
                      GothicButton(
                        text: 'Delete Account',
                        onPressed: () {
                          // TODO
                        },
                      ),
                      GothicButton(
                        text: 'Cerrar sesión',
                        onPressed: () => _logout(context),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
