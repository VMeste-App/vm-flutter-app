import 'dart:convert';

import 'package:meta/meta.dart';

@immutable
final class Token {
  final String token;
  final DateTime issuedAt;
  final DateTime expireAt;

  const Token({required this.token, required this.issuedAt, required this.expireAt});

  factory Token.decode(String jwt) {
    final parts = jwt.split('.');
    if (parts.length != 3) {
      throw const FormatException('Invalid token format, expected 3 parts separated by "."');
    }

    final <String>[_, encodedPayload, _] = parts;

    Map<String, Object?> payload;
    try {
      payload = const Base64Decoder()
          .fuse<String>(const Utf8Decoder())
          .fuse<Map<String, Object?>>(const JsonDecoder().cast<String, Map<String, Object?>>())
          .convert(const _NormalizeBase64Converter().convert(encodedPayload));
    } catch (e, st) {
      Error.throwWithStackTrace(FormatException('Can\'t decode token payload: error: $e'), st);
    }

    try {
      final issuedAtUnixTimestamp = (payload['iat']! as int) * 1000;
      final expireAtUnixTimestamp = (payload['iat']! as int) * 1000;
      final issuedAt = DateTime.fromMillisecondsSinceEpoch(issuedAtUnixTimestamp).toUtc();
      final expireAt = DateTime.fromMillisecondsSinceEpoch(expireAtUnixTimestamp).toUtc();

      return Token(token: jwt, issuedAt: issuedAt, expireAt: expireAt);
    } catch (e, st) {
      Error.throwWithStackTrace(FormatException('Invalid token payload data: $e'), st);
    }
  }

  bool get isExpired => DateTime.now().toUtc().isAfter(expireAt);

  @override
  String toString() {
    return 'Token('
        'token: $token, '
        'issuedAt: $issuedAt, '
        'expireAt: $expireAt, '
        ')';
  }
}

/// A converter thats normalizes Base64-encoded strings
///
/// [Problem](https://stackoverflow.com/questions/63941130/base64invalid-length-must-be-multiple-of-four-error-in-flutter)
class _NormalizeBase64Converter extends Converter<String, String> {
  const _NormalizeBase64Converter();

  @override
  String convert(String input) {
    final padding = (4 - input.length % 4) % 4;

    return input + '=' * padding;
  }
}
