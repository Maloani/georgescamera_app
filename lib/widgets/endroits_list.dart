// widgets/endroits_list.dart
import 'package:flutter/material.dart';
import '../modele/endroit.dart';
import '../vue/endroit_detail.dart';

class EndroitsList extends StatelessWidget {
  const EndroitsList({super.key, required this.endroits});

  final List<Endroit> endroits;

  @override
  Widget build(BuildContext context) {
    if (endroits.isEmpty) {
      return const Center(child: Text("Pas d'endroits favoris pour le moment"));
    }

    return ListView.builder(
      itemCount: endroits.length,
      itemBuilder: (ctx, index) {
        final e = endroits[index];

        return ListTile(
          leading: CircleAvatar(
            backgroundImage: e.image != null ? FileImage(e.image!) : null,
            child: e.image == null ? const Icon(Icons.place) : null,
          ),
          title: Text(e.nom),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => EndroitDetail(endroit: e)),
            );
          },
        );
      },
    );
  }
}
