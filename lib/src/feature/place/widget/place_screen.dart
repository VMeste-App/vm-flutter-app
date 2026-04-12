import 'package:flutter/material.dart';
import 'package:vm_app/src/core/widget/safe_scaffold.dart';
import 'package:vm_app/src/feature/place/model/place.dart';

class PlaceScreen extends StatelessWidget {
  const PlaceScreen({
    super.key,
    required this.id,
  });

  final PlaceId id;

  @override
  Widget build(BuildContext context) {
    return SafeScaffold(
      appBar: AppBar(
        title: const Text('Локации'),
      ),
      body: Container(),
    );
  }
}
