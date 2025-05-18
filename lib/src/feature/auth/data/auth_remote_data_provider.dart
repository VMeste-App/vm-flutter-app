import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:vm_app/src/core/model/typedefs.dart';
import 'package:vm_app/src/feature/auth/model/sign_in_request.dart';
import 'package:vm_app/src/feature/auth/model/sign_up_request.dart';
import 'package:vm_app/src/feature/auth/model/token.dart';
import 'package:vm_app/src/feature/auth/model/token_pair.dart';
import 'package:vm_app/src/feature/auth/model/user.dart';

abstract interface class IAuthRemoteDataProvider {
  Future<(User, TokenPair)> signUp(SignUpRequest signUpRequest);

  Future<(User, TokenPair)> signIn(SignInRequest signInRequest);
}

final class AuthRemoteDataProvider implements IAuthRemoteDataProvider {
  final http.Client _client;

  AuthRemoteDataProvider({required http.Client client}) : _client = client;

  static const _baseUrl = '/srv/auth/api';

  @override
  Future<(User, TokenPair)> signUp(SignUpRequest signUpRequest) async {
    final uri = Uri.parse('$_baseUrl/sign-up');
    final response = await _client.post(uri, body: jsonEncode(signUpRequest.toJson()));

    final tokenPair = _extractTokenPair(response);
    final user = User.fromJson(jsonDecode(response.body) as Json);

    return (user, tokenPair);
  }

  @override
  Future<(User, TokenPair)> signIn(SignInRequest signInRequest) async {
    final uri = Uri.parse('$_baseUrl/sign-in');

    final response = await _client.post(uri, body: jsonEncode(signInRequest.toJson()));

    final tokenPair = _extractTokenPair(response);
    final user = User.fromJson(jsonDecode(response.body) as Json);

    return (user, tokenPair);
  }

  TokenPair _extractTokenPair(Response response) {
    final headers = response.headers;

    final accessJwt = headers['authorization'];
    final refreshJwt = headers['authorization']; // TODO: Implement refresh token.

    if (accessJwt == null) {
      throw FormatException('Access JWT is empty', response.headers);
    }

    if (refreshJwt == null) {
      throw FormatException('Refresh JWT is empty', response.headers);
    }

    final accessToken = Token.decode(accessJwt);
    final refreshToken = Token.decode(refreshJwt);

    return TokenPair(accessToken: accessToken, refreshToken: refreshToken);
  }
}
