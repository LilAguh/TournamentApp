import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainNavigationShell extends StatelessWidget {
  final Widget child;

  const MainNavigationShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    int currentIndex = switch (location) {
      var l when l.startsWith('/home') => 0,
      var l when l.startsWith('/deck') => 1,
      var l when l.startsWith('/match') => 2,
      var l when l.startsWith('/tournaments') => 3,
      var l when l.startsWith('/profile') => 4,
      _ => 0,
    };

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green[400],
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: TextStyle(fontSize: 12),
        currentIndex: currentIndex,
        onTap: (i) {
          switch (i) {
            case 0:
              context.goNamed('home');
              break;
            case 1:
              context.goNamed('deck');
              break;
            case 2:
              context.goNamed('match');
              break;
            case 3:
              context.goNamed('tournaments');
              break;
            case 4:
              context.goNamed('profile');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard, size: 30),
            label: 'Deck',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.videogame_asset, size: 30),
            label: 'Match',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events, size: 30),
            label: 'Torneos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 30),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
