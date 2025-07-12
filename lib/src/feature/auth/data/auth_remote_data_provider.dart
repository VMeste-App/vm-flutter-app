import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vm_app/src/core/config/config.dart';
import 'package:vm_app/src/core/model/typedefs.dart';
import 'package:vm_app/src/feature/auth/data/model/auth_response.dart';
import 'package:vm_app/src/feature/auth/model/sign_in_request.dart';
import 'package:vm_app/src/feature/auth/model/sign_up_request.dart';

abstract interface class IAuthRemoteDataProvider {
  Future<AuthResponse> signUp(SignUpRequest signUpRequest);

  Future<AuthResponse> signIn(SignInRequest signInRequest);
}

final class AuthRemoteDataProvider implements IAuthRemoteDataProvider {
  final http.Client _client;

  AuthRemoteDataProvider({required http.Client client}) : _client = client;

  @override
  Future<AuthResponse> signUp(SignUpRequest signUpRequest) async {
    final uri = Uri.parse('${Config.apiUrl}/register');
    final response = await _client.post(uri, body: signUpRequest.toJson());

    return AuthResponse.fromJson(jsonDecode(response.body) as Json);
  }

  @override
  Future<AuthResponse> signIn(SignInRequest signInRequest) async {
    final uri = Uri.parse('${Config.apiUrl}/login');
    final response = await _client.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(signInRequest.toJson()),
    );

    return AuthResponse.fromJson(jsonDecode(response.body) as Json);
  }
}
