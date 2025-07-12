import 'package:meta/meta.dart';
import 'package:vm_app/src/feature/auth/model/token.dart';

@immutable
final class TokenPair {
  final JwtToken accessToken;
  final JwtToken refreshToken;

  const TokenPair({
    required this.accessToken,
    required this.refreshToken,
  });
}
