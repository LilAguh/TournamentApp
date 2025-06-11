import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainNavigationShell extends StatefulWidget {
  final Widget child;

  const MainNavigationShell({super.key, required this.child});

  @override
  State<MainNavigationShell> createState() => _MainNavigationShellState();
}

class _MainNavigationShellState extends State<MainNavigationShell> {
  int role = 1;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadRole();
  }

  Future<void> _loadRole() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      role = prefs.getInt('userRole') ?? 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    // Calcular currentIndex basado en el rol
    int calculateIndex() {
      if (role == 1 || role == 3) {
        // Jugador o juez
        return switch (location) {
          var l when l.startsWith('/home') => 0,
          var l when l.startsWith('/deck') => 1,
          var l when l.startsWith('/match') => 2,
          var l when l.startsWith('/tournaments') => 3,
          var l when l.startsWith('/profile') => 4,
          _ => 0,
        };
      } else {
        // Admin u organizador
        return switch (location) {
          var l when l.startsWith('/home') => 0,
          var l when l.startsWith('/tournaments') => 1,
          var l when l.startsWith('/profile') => 2,
          _ => 0,
        };
      }
    }

    final items = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(
        icon: Icon(Icons.home, size: 24),
        label: 'Home',
      ),
      if (role == 1 || role == 3)
        const BottomNavigationBarItem(
          icon: Icon(Icons.dashboard, size: 24),
          label: 'Deck',
        ),
      if (role == 1 || role == 3)
        const BottomNavigationBarItem(
          icon: Icon(Icons.videogame_asset, size: 24),
          label: 'Match',
        ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.emoji_events, size: 24),
        label: 'Torneos',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.person, size: 24),
        label: 'Perfil',
      ),
    ];

    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green[400],
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
        currentIndex: calculateIndex(),
        onTap: (i) {
          if (role == 1 || role == 3) {
            switch (i) {
              case 0:
                context.goNamed('home');
              case 1:
                context.goNamed('deck');
              case 2:
                context.goNamed('match');
              case 3:
                context.goNamed('tournaments');
              case 4:
                context.goNamed('profile');
            }
          } else {
            switch (i) {
              case 0:
                context.goNamed('home');
              case 1:
                context.goNamed('tournaments');
              case 2:
                context.goNamed('profile');
            }
          }
        },
        items: items,
      ),
    );
  }
}
