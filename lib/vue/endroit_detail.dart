// vue/endroit_detail.dart
import 'package:flutter/material.dart';
import '../modele/endroit.dart';
import '../services/navigation_service.dart';
import 'dart:io';

class EndroitDetail extends StatelessWidget {
  const EndroitDetail({super.key, required this.endroit});
  final Endroit endroit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(endroit.nom)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (endroit.image != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  endroit.image!,
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              )
            else
              const Icon(Icons.place, size: 90),

            const SizedBox(height: 12),

            if (endroit.hasLocation)
              Text(
                "Latitude: ${endroit.latitude}\nLongitude: ${endroit.longitude}",
                textAlign: TextAlign.center,
              )
            else
              const Text("Aucune position enregistrée."),

            const SizedBox(height: 16),

            // ✅ Mode hors ligne (fallback) : si tu stockes un snapshot local
            if (endroit.mapSnapshotPath != null &&
                File(endroit.mapSnapshotPath!).existsSync())
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  File(endroit.mapSnapshotPath!),
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

            const Spacer(),

            if (endroit.hasLocation)
              ElevatedButton.icon(
                onPressed: () {
                  NavigationService.ouvrirItineraire(
                    lat: endroit.latitude!,
                    lng: endroit.longitude!,
                  );
                },
                icon: const Icon(Icons.navigation),
                label: const Text("Démarrer l’itinéraire"),
              ),
          ],
        ),
      ),
    );
  }
}
