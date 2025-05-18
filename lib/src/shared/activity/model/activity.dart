import 'package:meta/meta.dart';

typedef ActivityID = int;

@immutable
final class Activity {
  final ActivityID id;
  final String name;

  const Activity({required this.id, required this.name});
}
