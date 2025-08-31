import 'package:meta/meta.dart';
import 'package:vm_app/src/core/model/typedefs.dart';
import 'package:vm_app/src/feature/auth/model/token_pair.dart' hide Token;
import 'package:vm_app/src/feature/auth/model/user.dart';

@immutable
final class AuthResponseDto {
  final User user;
  final TokenPair tokenPair;

  const AuthResponseDto({
    required this.user,
    required this.tokenPair,
  });

  factory AuthResponseDto.fromJson(Json json) {
    if (json case {
      // 'user': {
      //   'user_id': final String id,
      //   'email': final String email,
      // },
      'user_id': final UserID id,
      'access_token': final Token accessToken,
      'refresh_token': final Token refreshToken,
    }) {
      return AuthResponseDto(
        user: User(id: id, email: 'email'),
        tokenPair: TokenPair(
          accessToken: accessToken,
          refreshToken: refreshToken,
        ),
      );
    }

    throw FormatException('Returned response is not understood by the application', json);
  }
}
