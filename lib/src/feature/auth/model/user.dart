import 'package:meta/meta.dart';
import 'package:vm_app/src/core/model/typedefs.dart';

typedef UserId = String;

@immutable
class User {
  final UserId id;
  final String username;

  const User({required this.id, required this.username});

  factory User.fromJson(Json json) {
    if (json case {'user_id': final UserId id, 'username': final String username}) {
      return User(id: id, username: username);
    }

    throw FormatException('Returned response is not understood by the application', json);
  }

  Json toJson() {
    return {'user_id': id, 'username': username};
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id && other.username == username;
  }

  @override
  int get hashCode => id.hashCode ^ username.hashCode;
}
