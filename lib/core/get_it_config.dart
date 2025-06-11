import 'package:shared_preferences/shared_preferences.dart';
import 'package:tournament_app/features/auth/config/auth_config.dart';
import 'package:tournament_app/features/country/config/country_config.dart'
    hide sl;
import 'package:tournament_app/features/profile/config/profile_config.dart'
    hide sl;
// importar otros configs si los tenés en el futuro

Future<void> configureGetItApp() async {
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => prefs);

  await initAuthConfig();
  initCountryConfig();
  await initProfileConfig(); // esto ya no debe volver a registrar prefs
}
