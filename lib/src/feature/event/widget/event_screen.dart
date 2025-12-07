import 'package:flutter/material.dart';
import 'package:vm_app/src/core/widget/safe_scaffold.dart';
import 'package:vm_app/src/feature/event/model/event.dart';
import 'package:vm_app/src/shared/level/model/level.dart';
import 'package:vm_app/src/shared/sex/model/sex.dart';

class VmEventScreen extends StatelessWidget {
  const VmEventScreen({
    super.key,
    required this.id,
  });

  final VmEventID id;

  @override
  Widget build(BuildContext context) {
    final event = VmEvent(
      activityID: 1,
      level: Level.beginner,
      membersQtyUp: 4,
      membersQtyTo: 10,
      membersSex: Sex.mixed,
      membersAgeUp: 18,
      membersAgeTo: 40,
      sharedCost: 100,
      perPersonCost: 0,
      dt: DateTime.now(),
      duration: const Duration(hours: 2),
    );

    return SafeScaffold(
      appBar: AppBar(
        title: const Text('123132'),
      ),
      body: const Column(),
    );
  }
}
