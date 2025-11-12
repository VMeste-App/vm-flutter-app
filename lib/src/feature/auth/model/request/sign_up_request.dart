import 'package:meta/meta.dart';

@immutable
final class SignUpRequest {
  final String email;
  final String password;

  const SignUpRequest({
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
