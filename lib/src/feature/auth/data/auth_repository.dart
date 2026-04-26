import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vm_app/src/core/model/typedefs.dart';
import 'package:vm_app/src/core/network/vm_http_client.dart';
import 'package:vm_app/src/core/utils/persisted_entry.dart';
import 'package:vm_app/src/feature/auth/model/dto/auth_response_dto.dart';
import 'package:vm_app/src/feature/auth/model/request/sign_in_request.dart';
import 'package:vm_app/src/feature/auth/model/request/sign_up_request.dart';
import 'package:vm_app/src/feature/auth/model/token_pair.dart';
import 'package:vm_app/src/feature/auth/model/user.dart';

abstract interface class IAuthRepository {
  /// Восстановить данные авторизации.
  Future<User?> restore();

  /// Зарегистрироваться.
  Future<User> signUp(SignUpRequest request);

  /// Авторизоваться.
  Future<User> signIn(SignInRequest request);

  /// Выйти из аккаунта.
  Future<void> signOut();

  /// Удалить аккаунт.
  Future<void> deleteAccount();
}

final class AuthRepository implements IAuthRepository {
  final VmHttpClient _client;
  final SharedPreferencesAsync _storage;

  AuthRepository({
    required VmHttpClient client,
    required SharedPreferencesAsync storage,
  }) : _client = client,
       _storage = storage;

  // Token
  late final accessTokenEntry = StringPreferencesEntry(storage: _storage, key: 'token.access');
  late final refreshTokenEntry = StringPreferencesEntry(storage: _storage, key: 'token.refresh');

  // User
  late final userEntry = StringPreferencesEntry(storage: _storage, key: 'user');

  @override
  Future<User?> restore() async {
    final token = await accessTokenEntry.read();
    final user = await _loadUser();

    if (token == null || user == null) {
      return null;
    }

    return user;
  }

  @override
  Future<User> signUp(SignUpRequest request) async {
    final response = await _client.post('/register', body: request.toJson());
    final dto = AuthResponseDto.fromJson(response);
    await _saveData(dto);

    return dto.user;
  }

  @override
  Future<User> signIn(SignInRequest request) async {
    final response = await _client.post('/login', body: request.toJson());
    final dto = AuthResponseDto.fromJson(response);
    await _saveData(dto);

    return dto.user;
  }

  @override
  Future<void> signOut() async {
    await accessTokenEntry.remove();
    await refreshTokenEntry.remove();
    await userEntry.remove();
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

  @override
  Future<void> deleteAccount() async {
    await accessTokenEntry.remove();
    await refreshTokenEntry.remove();
    await userEntry.remove();
  }
}
