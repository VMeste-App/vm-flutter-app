import 'package:meta/meta.dart';

@immutable
final class SignUpRequest {
  final String username;
  final String password;

  const SignUpRequest({required this.username, required this.password});

  Map<String, Object?> toJson() {
    return {'username': username, 'password': password};
  }
}
