import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:vm_app/src/feature/event/model/event.dart';

class VmEventScreen extends StatelessWidget {
  const VmEventScreen({
    super.key,
    required this.id,
  });

  final VmEventId id;

  @override
  Widget build(BuildContext context) {
    // final event = VmEvent(
    //   activityID: 1,
    //   level: Level.beginner,
    //   membersQtyUp: 4,
    //   membersQtyTo: 10,
    //   membersSex: Sex.,
    //   membersAgeUp: 18,
    //   membersAgeTo: 40,
    //   sharedCost: 100,
    //   perPersonCost: 0,
    //   dt: DateTime.now(),
    //   duration: const Duration(hours: 2),
    // );

    return VmScaffold(
      appBar: AppBar(
        title: const Text('123132'),
      ),
      body: const Column(),
    );
  }
}
