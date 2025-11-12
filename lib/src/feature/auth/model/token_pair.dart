import 'package:meta/meta.dart';

typedef Token = String;

@immutable
final class TokenPair {
  final Token accessToken;
  final Token refreshToken;

  const TokenPair({
    required this.accessToken,
    required this.refreshToken,
  });
}
