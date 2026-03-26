import 'package:flutter/material.dart';
import 'package:vm_app/src/core/widget/safe_scaffold.dart';
import 'package:vm_app/src/feature/location/model/location.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({
    super.key,
    required this.id,
  });

  final LocationId id;

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
