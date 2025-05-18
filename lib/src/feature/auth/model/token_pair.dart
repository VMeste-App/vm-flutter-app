import 'package:meta/meta.dart';
import 'package:vm_app/src/feature/auth/model/token.dart';

@immutable
final class TokenPair {
  final Token accessToken;
  final Token refreshToken;

  const TokenPair({required this.accessToken, required this.refreshToken});
}
