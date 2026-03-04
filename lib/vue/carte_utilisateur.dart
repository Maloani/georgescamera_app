// vue/carte_utilisateur.dart
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../services/localisation_service.dart';

class CarteUtilisateur extends StatefulWidget {
  const CarteUtilisateur({super.key});

  @override
  State<CarteUtilisateur> createState() => _CarteUtilisateurState();
}

class _CarteUtilisateurState extends State<CarteUtilisateur> {
  GoogleMapController? _controller;
  LatLng? _positionUtilisateur;

  @override
  void initState() {
    super.initState();
    _chargerPosition();
  }

  Future<void> _chargerPosition() async {
    try {
      final position = await LocalisationService.obtenirPosition();
      setState(() {
        _positionUtilisateur = LatLng(position.latitude, position.longitude);
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_positionUtilisateur == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Ma position")),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _positionUtilisateur!,
          zoom: 15,
        ),
        myLocationEnabled: true,
        markers: {
          Marker(
            markerId: const MarkerId("moi"),
            position: _positionUtilisateur!,
            infoWindow: const InfoWindow(title: "Vous êtes ici"),
          ),
        },
        onMapCreated: (controller) => _controller = controller,
      ),
    );
  }
}
