import 'package:flutter/material.dart';
import 'package:octopus/octopus.dart';
import 'package:vm_app/src/core/router/routes.dart';
import 'package:vm_app/src/core/widget/safe_scaffold.dart';

/// {@template events_tab}
/// EventsTab widget.
/// {@endtemplate}
class EventsTab extends StatelessWidget {
  /// {@macro events_tab}
  const EventsTab({
    super.key, // ignore: unused_element
  });

  @override
  Widget build(BuildContext context) {
    return SafeScaffold(
      appBar: AppBar(
        title: const Text('События'),
        actions: [IconButton(onPressed: () => context.octopus.push(Routes.create), icon: const Icon(Icons.add))],
      ),
      body: Container(),
      // content: FTabs(
      //   initialIndex: 1,
      //   onPress: (index) {},
      //   tabs: const [
      //     FTabEntry(label: Text('Текущие'), content: SizedBox()),
      //     FTabEntry(label: Text('Прошедшие'), content: SizedBox()),
      //   ],
      // ),
    );
  }
}
