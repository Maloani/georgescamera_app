// widgets/image_prise.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePrise extends StatefulWidget {
  const ImagePrise({super.key, required this.onPhotoSelectionne});

  final void Function(File image) onPhotoSelectionne;

  @override
  State<ImagePrise> createState() => _ImagePriseState();
}

class _ImagePriseState extends State<ImagePrise> {
  File? _photoSelectionne;

  Future<void> _prendrePhoto() async {
    final picker = ImagePicker();
    final photoPrise = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1200,
      imageQuality: 85,
    );

    if (photoPrise == null) return;

    final file = File(photoPrise.path);
    setState(() => _photoSelectionne = file);

    widget.onPhotoSelectionne(file);
  }

  @override
  Widget build(BuildContext context) {
    if (_photoSelectionne == null) {
      return TextButton.icon(
        onPressed: _prendrePhoto,
        icon: const Icon(Icons.camera_alt),
        label: const Text("Prendre photo"),
      );
    }

    return GestureDetector(
      onTap: _prendrePhoto,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.file(
          _photoSelectionne!,
          height: 220,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
