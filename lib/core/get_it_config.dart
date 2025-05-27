import 'package:tournament_app/features/auth/config/auth_config.dart';
import 'package:tournament_app/features/country/config/country_config.dart';
// importar otros configs si los tenés en el futuro

Future<void> configureGetItApp() async {
  await initAuthConfig();
  initCountryConfig();
  // initProfileConfig();
  // initTournamentConfig();
}
