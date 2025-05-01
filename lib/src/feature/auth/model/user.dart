import 'package:meta/meta.dart';

typedef UserId = String;

@immutable
class User {
  const User({required this.id});

  final UserId id;
}
