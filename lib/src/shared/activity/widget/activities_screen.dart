import 'package:flutter/material.dart';
import 'package:vm_app/src/core/ui-kit/picker_group.dart';
import 'package:vm_app/src/core/widget/safe_scaffold.dart';
import 'package:vm_app/src/shared/activity/model/activity.dart';
import 'package:vm_app/src/shared/activity/widget/activity_scope.dart';

class ActivitiesScreen extends StatefulWidget {
  const ActivitiesScreen({super.key, this.selected});

  final ActivityID? selected;

  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  late final ValueNotifier<ActivityID?> _activityController;

  @override
  void initState() {
    super.initState();
    _activityController = ValueNotifier(widget.selected);
  }

  @override
  void dispose() {
    _activityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final activities = ActivityScope.activitiesOf(context).map((e) => PickerItem(id: e.id, title: e.name)).toList();

    return ValueListenableBuilder<ActivityID?>(
      valueListenable: _activityController,
      builder: (context, selected, _) {
        return SafeScaffold(
          appBar: AppBar(title: const Text('Активность')),
          body: VmPickerGroup(
            controller: _activityController,
            items: activities,
          ),
          persistentFooterButtons: [
            FilledButton(
              onPressed: selected == null ? null : () => Navigator.of(context).pop(selected),
              child: const Text('Выбрать'),
            ),
          ],
        );
      },
    );
  }
}
