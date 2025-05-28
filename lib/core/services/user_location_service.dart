import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ip_country_lookup/ip_country_lookup.dart';
import 'package:ip_country_lookup/models/ip_country_data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLocationService {
  /// Devuelve (code, name) → ej: ("AR", "Argentina")
  Future<(String code, String name)?> getBestAvailableCountry() async {
    // 1. Intentar geolocalización con permiso
    final geoResult = await _getFromGeolocator();
    if (geoResult != null) return geoResult;

    // 2. Fallback → obtener por IP
    final ipResult = await _getFromIpLookup();
    if (ipResult != null) return ipResult;

    // 3. Falla total
    return null;
  }

  Future<(String code, String name)?> _getFromGeolocator() async {
    try {
      final enabled = await Geolocator.isLocationServiceEnabled();
      if (!enabled) return null;

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) return null;
      }
      if (permission == LocationPermission.deniedForever) return null;

      final position = await Geolocator.getCurrentPosition();
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final code = placemarks.first.isoCountryCode ?? '??';
        final name = placemarks.first.country ?? 'Desconocido';
        print('[CountryService] (GPS) $name ($code)');
        return (code, name);
      }
    } catch (e) {
      print('[CountryService] Error usando geolocator: $e');
    }

    return null;
  }

  Future<(String code, String name)?> _getFromIpLookup() async {
    try {
      final result = await IpCountryLookup().getIpLocationData();
      if (result != null) {
        final code = result.country_code ?? '??';
        final name = result.country_name ?? 'Desconocido';
        print('[CountryService] (IP) $name ($code)');
        return (code, name);
      }
    } catch (e) {
      print('[CountryService] Error usando IP lookup: $e');
    }

    return null;
  }

  Future<void> saveCountryAndCodeToPrefs(String code, String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_country_code', code);
    await prefs.setString('user_country_name', name);
  }
}
