// services/localisation_service.dart
import 'package:geolocator/geolocator.dart';

class LocalisationService {
  static Future<Position> obtenirPosition() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception("Service de localisation désactivé");
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("Permission localisation refusée");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception("Permission localisation refusée définitivement");
    }

    return Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}
