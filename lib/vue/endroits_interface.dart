// vue/endroits_interface.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/endroits_utilisateurs.dart';
import '../widgets/endroits_list.dart';
import 'ajout_endroit.dart';

class EndroitsInterface extends ConsumerStatefulWidget {
  const EndroitsInterface({super.key});

  @override
  ConsumerState<EndroitsInterface> createState() => _EndroitsInterfaceState();
}

class _EndroitsInterfaceState extends ConsumerState<EndroitsInterface> {
  bool _loaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_loaded) {
      _loaded = true;
      ref.read(endroitsProvider.notifier).chargerDepuisSQLite();
    }
  }

  @override
  Widget build(BuildContext context) {
    final endroits = ref.watch(endroitsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mes endroits préférés"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const AjoutEndroit()));
            },
          ),
        ],
      ),
      body: EndroitsList(endroits: endroits),
    );
  }
}
