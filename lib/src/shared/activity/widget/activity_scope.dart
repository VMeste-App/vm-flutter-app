import 'package:flutter/widgets.dart';
import 'package:vm_app/src/core/utils/extensions/context_extension.dart';
import 'package:vm_app/src/shared/activity/model/activity.dart';

final _activities = [
  const Activity(id: 1, name: 'Футбол'),
  const Activity(id: 2, name: 'Баскетбол'),
  const Activity(id: 3, name: 'Волейбол'),
];

final _activitiesMap = {
  1: const Activity(id: 1, name: 'Футбол'),
  2: const Activity(id: 2, name: 'Баскетбол'),
  3: const Activity(id: 3, name: 'Волейбол'),
};

class ActivityScope extends StatelessWidget {
  const ActivityScope({super.key, required this.child});

  final Widget child;

  static List<Activity> activitiesOf(BuildContext context) => context.inhOf<_InheritedActivity>().activities;

  static Activity? activityOf(BuildContext context, ActivityID id) =>
      context.inhOf<_InheritedActivity>().activitiesMap[id];

  @override
  Widget build(BuildContext context) {
    return _InheritedActivity(activities: _activities, activitiesMap: _activitiesMap, child: child);
  }
}

class _InheritedActivity extends InheritedWidget {
  const _InheritedActivity({required this.activities, required this.activitiesMap, required super.child});

  final Map<ActivityID, Activity> activitiesMap;
  final List<Activity> activities;

  @override
  bool updateShouldNotify(covariant _InheritedActivity oldWidget) => activities != oldWidget.activities;
}
