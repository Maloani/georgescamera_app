// providers/endroits_utilisateurs.dart
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/db_helper.dart';
import '../modele/endroit.dart';

class EndroitsUtilisateur extends StateNotifier<List<Endroit>> {
  EndroitsUtilisateur() : super(const []);

  Future<void> chargerDepuisSQLite() async {
    final data = await DBHelper.getEndroits();
    state = data.map((row) {
      return Endroit(
        id: row['id'] as String,
        nom: row['nom'] as String,
        image: (row['imagePath'] as String?) != null
            ? File(row['imagePath'] as String)
            : null,
        latitude: (row['latitude'] as num?)?.toDouble(),
        longitude: (row['longitude'] as num?)?.toDouble(),
        address: row['address'] as String?,
        mapSnapshotPath: row['mapSnapshotPath'] as String?,
      );
    }).toList();
  }

  Future<void> ajoutEndroit(
    String nom, {
    File? image,
    double? latitude,
    double? longitude,
    String? address,
    String? mapSnapshotPath,
  }) async {
    final nomNettoye = nom.trim();
    if (nomNettoye.isEmpty) return;

    final e = Endroit(
      nom: nomNettoye,
      image: image,
      latitude: latitude,
      longitude: longitude,
      address: address,
      mapSnapshotPath: mapSnapshotPath,
    );

    await DBHelper.insertEndroit({
      'id': e.id,
      'nom': e.nom,
      'imagePath': e.image?.path,
      'latitude': e.latitude,
      'longitude': e.longitude,
      'address': e.address,
      'mapSnapshotPath': e.mapSnapshotPath,
    });

    state = [e, ...state];
  }

  Future<void> supprimerEndroit(String id) async {
    await DBHelper.deleteEndroit(id);
    state = state.where((e) => e.id != id).toList();
  }
}

final endroitsProvider =
    StateNotifierProvider<EndroitsUtilisateur, List<Endroit>>(
      (ref) => EndroitsUtilisateur(),
    );
