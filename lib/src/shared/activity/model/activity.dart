import 'package:meta/meta.dart';

typedef ActivityId = int;

@immutable
final class Activity {
  final ActivityId id;
  final String name;

  const Activity({
    required this.id,
    required this.name,
  });
}
