import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ip_country_lookup/ip_country_lookup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLocationService {
  /// Devuelve (code, name) → ej: ("AR", "Argentina")
  ///
  Future<(String, String)?> getBestAvailableCountry() async {
    // 1. Intentar geolocalización con permiso
    final geoResult = await _getFromGeolocator();
    if (geoResult != null) return geoResult;

    // 2. Fallback → obtener por IP
    final ipResult = await _getFromIpLookup();
    if (ipResult != null) return ipResult;

    // 3. Falla total
    return null;
  }

  Future<(String, String)?> _getFromGeolocator() async {
    try {
      final enabled = await Geolocator.isLocationServiceEnabled();
      if (!enabled) return null;

      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever)
        return null;

      final position = await Geolocator.getCurrentPosition();
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      return (
        placemarks.first.isoCountryCode ?? '??',
        placemarks.first.country ?? 'Desconocido',
      );

      /*
      if (placemarks.isNotEmpty) {
        final code = placemarks.first.isoCountryCode ?? '??';
        final name = placemarks.first.country ?? 'Desconocido';
        debugPrint('[CountryService] (GPS) $name ($code)');
        return (code, name);}
        
      */
    } catch (e) {
      debugPrint('[CountryService] Error usando geolocator: $e');
      return null;
    }
  }

  Future<(String, String)?> _getFromIpLookup() async {
    try {
      final result = await IpCountryLookup().getIpLocationData();
      return (
        result.country_code ?? '??',
        result.country_name ?? 'Desconocido',
      );

      /*
     if (result != null) {
        final code = result.country_code ?? '??';
        final name = result.country_name ?? 'Desconocido';
        debugPrint('[CountryService] (IP) $name ($code)');
        return (code, name);
      } */
    } catch (e) {
      debugPrint('[CountryService] Error usando IP lookup: $e');
      return null;
    }
  }

  // ¿Por qué guardar el país y código de forma local?
  // no convendría chequear siempre la ubicación del usuario?
  Future<void> saveCountryAndCodeToPrefs(String code, String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_country_code', code);
    await prefs.setString('user_country_name', name);
  }
}
