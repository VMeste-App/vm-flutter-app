import 'package:meta/meta.dart';
import 'package:vm_app/src/core/model/typedefs.dart';

typedef UserID = int;

@immutable
class User {
  final UserID id;
  final String email;

  const User({
    required this.id,
    required this.email,
  });

  factory User.fromJson(Json json) {
    if (json case {'user_id': final UserID id, 'username': final String email}) {
      return User(id: id, email: email);
    }

    throw FormatException('Returned response is not understood by the application', json);
  }

  Json toJson() {
    return {
      'user_id': id,
      'email': email,
    };
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id && other.email == email;
  }

  @override
  int get hashCode => id.hashCode ^ email.hashCode;
}
