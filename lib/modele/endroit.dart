// modele/endroit.dart
import 'dart:io';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Endroit {
  Endroit({
    String? id,
    required this.nom,
    File? image,
    this.latitude,
    this.longitude,
    this.address,
    this.mapSnapshotPath,
  }) : id = id ?? uuid.v4(),
       image = image;

  final String id;
  final String nom;
  final File? image;

  final double? latitude;
  final double? longitude;
  final String? address;

  /// Mode hors ligne : image locale (aperçu) de la carte, si tu veux l’enregistrer
  final String? mapSnapshotPath;

  bool get hasLocation => latitude != null && longitude != null;
}
