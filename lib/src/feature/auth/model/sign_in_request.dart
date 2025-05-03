import 'package:meta/meta.dart';

@immutable
final class SignInRequest {
  final String username;
  final String password;

  const SignInRequest({required this.username, required this.password});

  Map<String, Object?> toJson() {
    return {'username': username, 'password': password};
  }
}
