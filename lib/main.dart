// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'vue/endroits_interface.dart';

void main() {
  runApp(const ProviderScope(child: MonApplication()));
}

class MonApplication extends StatelessWidget {
  const MonApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Endroits favoris',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.orange),
      home: const EndroitsInterface(),
    );
  }
}
