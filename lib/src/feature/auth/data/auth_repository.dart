import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;
import 'package:vm_app/src/core/model/typedefs.dart';
import 'package:vm_app/src/core/utils/persisted_entry.dart';
import 'package:vm_app/src/feature/auth/model/dto/auth_response_dto.dart';
import 'package:vm_app/src/feature/auth/model/request/sign_in_request.dart';
import 'package:vm_app/src/feature/auth/model/request/sign_up_request.dart';
import 'package:vm_app/src/feature/auth/model/token_pair.dart';
import 'package:vm_app/src/feature/auth/model/user.dart';

abstract interface class IAuthRepository {
  Future<User> signUp(SignUpRequest request);

  Future<User> signIn(SignInRequest request);

  Future<void> signOut();

  Future<User?> restore();
}

final class AuthRepository implements IAuthRepository {
  final Dio _client;
  final SharedPreferencesAsync _storage;

  AuthRepository({
    required Dio client,
    required SharedPreferencesAsync storage,
  }) : _client = client,
       _storage = storage;

  // Token
  late final accessTokenEntry = StringPreferencesEntry(storage: _storage, key: 'token.access');
  late final refreshTokenEntry = StringPreferencesEntry(storage: _storage, key: 'token.refresh');

  // User
  late final userEntry = StringPreferencesEntry(storage: _storage, key: 'user');

  @override
  Future<User> signUp(SignUpRequest request) async {
    final response = await _client.post<Json>('/register', data: request.toJson());
    final dto = AuthResponseDto.fromJson(response.data!);
    await _saveData(dto);

    return dto.user;
  }

  @override
  Future<User> signIn(SignInRequest request) async {
    final response = await _client.post<Json>('/login', data: request.toJson());
    final dto = AuthResponseDto.fromJson(response.data!);
    await _saveData(dto);

    return dto.user;
  }

  @override
  Future<void> signOut() async {
    await accessTokenEntry.remove();
    await refreshTokenEntry.remove();
    await userEntry.remove();
  }

  @override
  Future<User?> restore() async {
    final token = await accessTokenEntry.read();
    final user = await _loadUser();

    if (token == null || user == null) {
      return null;
    }

    return user;
  }

  Future<void> _saveData(AuthResponseDto data) async {
    await _saveTokenPair(data.tokenPair);
    await _saveUser(data.user);
  }

  Future<void> _saveUser(User user) async {
    final encodedUser = jsonEncode(user.toJson());
    await userEntry.set(encodedUser);
  }

  Future<void> _saveTokenPair(TokenPair tokenPair) async {
    await accessTokenEntry.set(tokenPair.accessToken);
    await refreshTokenEntry.set(tokenPair.refreshToken);
  }

  Future<User?> _loadUser() async {
    final encodedUser = await userEntry.read();
    if (encodedUser == null) return null;

    final decodedUser = jsonDecode(encodedUser) as Json?;
    if (decodedUser == null) return null;

    return User.fromJson(decodedUser);
  }
}

final class AuthRepository$Supabase implements IAuthRepository {
  final Supabase _supabase;

  AuthRepository$Supabase({required Supabase supabase}) : _supabase = supabase;

  @override
  Future<User> signUp(SignUpRequest request) async {
    final response = await _supabase.client.auth.signUp(
      email: request.email,
      password: request.password,
    );

    return User(
      id: response.user.id,
      email: response.user.email,
    );
  }

  @override
  Future<User> signIn(SignInRequest request) async {
    final response = await _supabase.client.auth.signInWithPassword(
      email: request.email,
      password: request.password,
    );

    return User(
      id: response.user.id,
      email: response.user.email,
    );
  }

  @override
  Future<User?> restore() => Future.value();

  @override
  Future<void> signOut() => _supabase.client.auth.signOut();
}
