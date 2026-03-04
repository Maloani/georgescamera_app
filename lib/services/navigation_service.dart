// services/navigation_service.dart
import 'package:url_launcher/url_launcher.dart';

class NavigationService {
  static Future<void> ouvrirItineraire({
    required double lat,
    required double lng,
  }) async {
    final uri = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng&travelmode=driving',
    );
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception("Impossible d’ouvrir l’app de navigation");
    }
  }
}
