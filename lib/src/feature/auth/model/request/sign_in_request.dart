import 'package:meta/meta.dart';

@immutable
final class SignInRequest {
  final String email;
  final String password;

  const SignInRequest({
    required this.email,
    required this.password,
  });

  Map<String, Object?> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
