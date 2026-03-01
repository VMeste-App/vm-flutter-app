import 'package:meta/meta.dart';
import 'package:vm_app/src/shared/activity/model/activity.dart';
import 'package:vm_app/src/shared/level/model/level.dart';

@immutable
final class SearchFilter {
  final List<ActivityID>? activities;
  final List<SkillLevel>? levels;
  final ValueRange<DateTime>? dt;
  final ValueRange<int>? age;
  final ValueRange<int>? membersQty;
  final ValueRange<int>? price;
  final ValueRange<int>? duration;

  const SearchFilter({
    this.activities,
    this.levels,
    this.dt,
    this.age,
    this.membersQty,
    this.price,
    this.duration,
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
