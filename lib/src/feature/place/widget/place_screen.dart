import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:vm_app/src/feature/place/model/place.dart';

class PlaceScreen extends StatelessWidget {
  const PlaceScreen({
    super.key,
    required this.id,
  });

  final PlaceId id;

  @override
  Widget build(BuildContext context) {
    return VmScaffold(
      appBar: AppBar(
        title: const Text('Локации'),
      ),
      body: Container(),
    );
  }
}
