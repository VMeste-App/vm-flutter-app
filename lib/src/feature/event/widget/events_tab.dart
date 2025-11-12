import 'package:flutter/material.dart';
import 'package:vm_app/src/core/navigator/navigator.dart';
import 'package:vm_app/src/core/navigator/pages.dart';
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
        actions: [
          IconButton(
            onPressed: () => VmNavigator.push(
              context,
              const CreateEventPage(),
            ),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: const SizedBox(),
    );
  }
}
