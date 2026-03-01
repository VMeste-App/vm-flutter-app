import 'package:flutter/material.dart';
import 'package:vm_app/src/core/navigator/navigator.dart';
import 'package:vm_app/src/core/navigator/pages.dart';
import 'package:vm_app/src/core/widget/safe_scaffold.dart';

class EventsTab extends StatelessWidget {
  const EventsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeScaffold(
      appBar: AppBar(
        title: const Text('События'),
        actions: [
          IconButton(
            onPressed: () => VmNavigator.push(context, const CreateEventPage()),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Container(),
    );
  }
}
