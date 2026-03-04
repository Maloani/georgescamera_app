// vue/selection_carte.dart
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../services/localisation_service.dart';

class SelectionCarte extends StatefulWidget {
  const SelectionCarte({super.key});

  @override
  State<SelectionCarte> createState() => _SelectionCarteState();
}

class _SelectionCarteState extends State<SelectionCarte> {
  LatLng? _picked;
  LatLng? _initial;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _initPosition();
  }

  Future<void> _initPosition() async {
    try {
      final p = await LocalisationService.obtenirPosition();
      _initial = LatLng(p.latitude, p.longitude);
    } catch (_) {
      // fallback : centre par défaut (tu peux changer)
      _initial = const LatLng(0.0, 0.0);
    }
    setState(() => _loading = false);
  }

  void _selectPoint(LatLng pos) {
    setState(() => _picked = pos);
  }

  void _valider() {
    if (_picked == null) return;
    Navigator.of(context).pop(_picked);
  }

  @override
  Widget build(BuildContext context) {
    if (_loading || _initial == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sélectionner un point"),
        actions: [
          IconButton(
            onPressed: _picked == null ? null : _valider,
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: _initial!, zoom: 14),
        myLocationEnabled: true,
        onTap: _selectPoint,
        markers: {
          if (_picked != null)
            Marker(markerId: const MarkerId("picked"), position: _picked!),
        },
      ),
    );
  }
}
