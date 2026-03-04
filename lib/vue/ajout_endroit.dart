// vue/ajout_endroit.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/endroits_utilisateurs.dart';
import '../widgets/image_prise.dart';
import 'selection_carte.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AjoutEndroit extends ConsumerStatefulWidget {
  const AjoutEndroit({super.key});

  @override
  ConsumerState<AjoutEndroit> createState() => _AjoutEndroitState();
}

class _AjoutEndroitState extends ConsumerState<AjoutEndroit> {
  final _nomController = TextEditingController();
  File? _image;
  LatLng? _picked;

  @override
  void dispose() {
    _nomController.dispose();
    super.dispose();
  }

  Future<void> _ouvrirCarte() async {
    final res = await Navigator.of(
      context,
    ).push<LatLng>(MaterialPageRoute(builder: (_) => const SelectionCarte()));
    if (res == null) return;
    setState(() => _picked = res);
  }

  Future<void> _enregistrer() async {
    await ref
        .read(endroitsProvider.notifier)
        .ajoutEndroit(
          _nomController.text,
          image: _image,
          latitude: _picked?.latitude,
          longitude: _picked?.longitude,
        );
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ajout d'un nouvel endroit")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nomController,
              decoration: const InputDecoration(
                labelText: "Nom d'endroit",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 14),
            ImagePrise(onPhotoSelectionne: (img) => _image = img),
            const SizedBox(height: 14),

            OutlinedButton.icon(
              onPressed: _ouvrirCarte,
              icon: const Icon(Icons.map),
              label: Text(
                _picked == null
                    ? "Choisir un point sur la carte"
                    : "Point choisi: ${_picked!.latitude.toStringAsFixed(5)}, ${_picked!.longitude.toStringAsFixed(5)}",
              ),
            ),

            const SizedBox(height: 18),
            ElevatedButton.icon(
              onPressed: _enregistrer,
              icon: const Icon(Icons.save),
              label: const Text("Enregistrer"),
            ),
          ],
        ),
      ),
    );
  }
}
