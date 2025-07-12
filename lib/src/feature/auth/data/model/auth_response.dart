import 'package:meta/meta.dart';
import 'package:vm_app/src/core/model/typedefs.dart';
import 'package:vm_app/src/feature/auth/model/token.dart';
import 'package:vm_app/src/feature/auth/model/token_pair.dart';
import 'package:vm_app/src/feature/auth/model/user.dart';

@immutable
final class AuthResponse {
  final User user;
  final TokenPair tokenPair;

  const AuthResponse({
    required this.user,
    required this.tokenPair,
  });

  factory AuthResponse.fromJson(Json json) {
    if (json case {
      // 'user': {
      //   'user_id': final String id,
      //   'email': final String email,
      // },
      'user_id': final UserID id,
      'access_token': final String accessToken,
      'refresh_token': final String refreshToken,
    }) {
      return AuthResponse(
        user: User(id: id, email: 'email'),
        tokenPair: TokenPair(
          accessToken: JwtToken.decode(accessToken),
          refreshToken: JwtToken.decode(refreshToken),
        ),
      );
    }

    throw FormatException('Returned response is not understood by the application', json);
  }
}
