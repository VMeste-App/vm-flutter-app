import 'package:meta/meta.dart';

enum Sex { male, female, mixed }

enum Level { beginner, intermediate, advanced, pro }

typedef ActivityID = String;

@immutable
final class Activity {
  final ActivityID id;
  final String name;

  const Activity({required this.id, required this.name});
}

@immutable
final class AgeConstraints {
  final int min;
  final int? max;

  const AgeConstraints({this.min = 0, required this.max}) : assert(max == null || min <= max, '');
}

typedef VmEventID = int;

@immutable
final class VmEvent {
  final VmEventID id;
  final ActivityID activityID;
  final Sex sex;
  final Level level;
  final DateTime dt;
  final Duration duration;
  final int spots;
  final int? price;
  final String? description;

  const VmEvent({
    this.id = -1,
    required this.activityID,
    required this.sex,
    required this.level,
    required this.dt,
    required this.duration,
    required this.spots,
    required this.price,
    required this.description,
  });
}

typedef VmEvents = List<VmEvent>;

final class PagedData<T extends Object> {
  final List<T> data;
  final int page;
  final bool endReached;

  PagedData({required this.data, required this.page, required this.endReached});
}
