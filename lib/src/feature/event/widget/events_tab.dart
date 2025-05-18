import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:octopus/octopus.dart';
import 'package:vm_app/src/core/router/routes.dart';

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
    return FScaffold(
      header: FHeader.nested(
        title: const Text('События'),
        suffixActions: [
          FButton.icon(child: FIcon(FAssets.icons.plus), onPress: () => context.octopus.push(Routes.create)),
        ],
      ),
      content: FTabs(
        initialIndex: 1,
        onPress: (index) {},
        tabs: const [
          FTabEntry(label: Text('Текущие'), content: SizedBox()),
          FTabEntry(label: Text('Прошедшие'), content: SizedBox()),
        ],
      ),
    );
  }
}
