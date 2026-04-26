import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:vm_app/src/core/initialization/fake/data/fake_data.dart';
import 'package:vm_app/src/core/navigator/navigator.dart';
import 'package:vm_app/src/core/navigator/pages.dart';
import 'package:vm_app/src/core/widget/lazy_scroll_view.dart';
import 'package:vm_app/src/feature/event/widget/event_card.dart';

/// {@template events_tab}
/// EventsTab widget.
/// {@endtemplate}
class SearchTab extends StatelessWidget {
  /// {@macro events_tab}
  const SearchTab({
    super.key, // ignore: unused_element
  });

  @override
  Widget build(BuildContext context) {
    return VmScaffold(
      appBar: AppBar(
        title: const Text('Поиск'),
        actions: [
          IconButton(
            onPressed: () => VmNavigator.push(
              context,
              const FilterPage(),
            ),
            icon: const Icon(Icons.filter_list_rounded),
          ),
        ],
      ),
      body: LazyScrollView(
        onRefresh: () async {
          await Future<void>.delayed(const Duration(seconds: 5));
        },
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          itemCount: 10,
          separatorBuilder: (context, index) => const SizedBox(height: 12.0),
          itemBuilder: (context, index) {
            final event = FakeData.events[index % FakeData.events.length];

            return VmEventCard(
              onPressed: () => VmNavigator.push(context, VmEventPage(id: event.id)),
              event: event,
            );
          },
        ),
      ),
    );
  }
}
