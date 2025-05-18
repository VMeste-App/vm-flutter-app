import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vm_app/src/core/utils/persisted_entry.dart';
import 'package:vm_app/src/feature/auth/model/token.dart';
import 'package:vm_app/src/feature/auth/model/token_pair.dart';
import 'package:vm_app/src/feature/auth/model/user.dart';

abstract interface class IAuthLocalDataProvider {
  Stream<User?> get userStream;

  Stream<TokenPair?> get tokenPairStream;

  Future<void> restore();

  Future<User?> loadUser();

  Future<TokenPair?> loadTokenPair();

  Future<void> saveUser(User user);

  Future<void> saveTokenPair(TokenPair tokenPair);

  Future<void> clear();
}

final class AuthLocalDataProvider implements IAuthLocalDataProvider {
  AuthLocalDataProvider({required SharedPreferences storage}) : _storage = storage;

  final SharedPreferences _storage;

  // Token
  late final accessTokenEntry = StringPreferencesEntry(storage: _storage, key: 'token.access');
  late final refreshTokenEntry = StringPreferencesEntry(storage: _storage, key: 'token.refresh');

  // User
  late final userEntry = StringPreferencesEntry(storage: _storage, key: 'user');

  // ignore: close_sinks
  final _userStreamController = StreamController<User?>.broadcast();

  // ignore: close_sinks
  final _tokenStreamController = StreamController<TokenPair?>.broadcast();

  @override
  Stream<User?> get userStream => _userStreamController.stream;

  @override
  Stream<TokenPair?> get tokenPairStream => _tokenStreamController.stream;

  @override
  Future<void> restore() async {
    final user = await loadUser();
    final tokenPair = await loadTokenPair();

    if (tokenPair != null) {
      _tokenStreamController.add(tokenPair);
    }

    if (user != null) {
      _userStreamController.add(user);
    }
  }

  @override
  Future<TokenPair?> loadTokenPair() async {
    final accessTokenString = await accessTokenEntry.read();
    final refreshTokenString = await refreshTokenEntry.read();

    if (accessTokenString == null || refreshTokenString == null) {
      return null;
    }

    final accessToken = Token.decode(accessTokenString);
    final refreshToken = Token.decode(refreshTokenString);

    return TokenPair(accessToken: accessToken, refreshToken: refreshToken);
  }

  @override
  Future<User?> loadUser() async {
    final encodedUser = await userEntry.read();
    if (encodedUser == null) return null;

    final decodedUser = jsonDecode(encodedUser) as Map<String, Object?>?;
    if (decodedUser == null) return null;

    return User.fromJson(decodedUser);
  }

  @override
  Future<void> saveUser(User user) async {
    final encodedUser = jsonEncode(user.toJson());
    await userEntry.set(encodedUser);

    _userStreamController.add(user);
  }

  @override
  Future<void> saveTokenPair(TokenPair tokenPair) async {
    await accessTokenEntry.set(tokenPair.accessToken.token);
    await refreshTokenEntry.set(tokenPair.refreshToken.token);

    _tokenStreamController.add(tokenPair);
  }

  @override
  Future<void> clear() async {
    await accessTokenEntry.remove();
    await refreshTokenEntry.remove();
    await userEntry.remove();

    _userStreamController.add(null);
    _tokenStreamController.add(null);
  }
}
