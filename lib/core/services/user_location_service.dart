import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class UserLocationService {
  Future<(String code, String name)?> getCountryData() async {
    try {
      print('[Geo] Verificando si la ubicación está habilitada...');
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print('[Geo] Servicio de ubicación deshabilitado');
        return null;
      }

      print('[Geo] Verificando permisos...');
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('[Geo] Permiso de ubicación denegado');
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        print('[Geo] Permiso de ubicación denegado permanentemente');
        return null;
      }

      print('[Geo] Obteniendo posición...');
      final position = await Geolocator.getCurrentPosition();
      print('[Geo] Posición: ${position.latitude}, ${position.longitude}');

      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final code = placemarks.first.isoCountryCode ?? '??';
        final name = placemarks.first.country ?? 'Desconocido';

        print('[Geo] País detectado: $name ($code)');
        return (code, name);
      }

      print('[Geo] No se encontró ningún placemark');
      return null;
    } catch (e) {
      print('[Geo] Error al obtener ubicación: $e');
      return null;
    }
  }
}
