import 'package:meta/meta.dart';
import 'package:vm_app/src/shared/activity/model/activity.dart';
import 'package:vm_app/src/shared/level/model/level.dart';

@immutable
final class EventFilter {
  final List<ActivityID> activities;
  final List<Level> levels;
  final ValueRange<DateTime> dt;
  final ValueRange<int> age;
  final ValueRange<int> membersQty;
  final ValueRange<int> price;
  final ValueRange<int> duration;

  const EventFilter({
    this.activities = const [],
    this.levels = const [],
    required this.dt,
    required this.age,
    required this.membersQty,
    required this.price,
    required this.duration,
  });
}

@immutable
final class ValueRange<T> {
  final T? min;
  final T? max;
  final bool includeMin;
  final bool includeMax;

  const ValueRange({
    required this.min,
    required this.max,
    this.includeMin = true,
    this.includeMax = true,
  });

  @override
  String toString() => 'ValueRange(min: $min, max: $max, includeMin: $includeMin, includeMax: $includeMax)';
}
