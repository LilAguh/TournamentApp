import 'package:tournament_app/features/auth/config/auth_config.dart';
// importar otros configs si los tenés en el futuro

Future<void> configureGetItApp() async {
  await initAuthConfig();
  // initProfileConfig();
  // initTournamentConfig();
}
