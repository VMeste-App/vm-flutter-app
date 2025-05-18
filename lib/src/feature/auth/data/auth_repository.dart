import 'package:vm_app/src/feature/auth/data/auth_local_data_provider.dart';
import 'package:vm_app/src/feature/auth/data/auth_remote_data_provider.dart';
import 'package:vm_app/src/feature/auth/model/sign_in_request.dart';
import 'package:vm_app/src/feature/auth/model/sign_up_request.dart';
import 'package:vm_app/src/feature/auth/model/user.dart';

abstract interface class IAuthRepository {
  Future<void> restore();

  Future<User> signUp(SignUpRequest request);

  Future<User> signIn(SignInRequest request);

  Future<void> signOut();
}

final class AuthRepository implements IAuthRepository {
  final IAuthLocalDataProvider _localDataProvider;
  final IAuthRemoteDataProvider _remoteDataProvider;

  AuthRepository({
    required IAuthLocalDataProvider localDataProvider,
    required IAuthRemoteDataProvider remoteDataProvider,
  }) : _localDataProvider = localDataProvider,
       _remoteDataProvider = remoteDataProvider;

  @override
  Future<void> restore() => _localDataProvider.restore();

  @override
  Future<User> signUp(SignUpRequest request) async {
    final (user, tokenPair) = await _remoteDataProvider.signUp(request);
    await _localDataProvider.saveTokenPair(tokenPair);
    await _localDataProvider.saveUser(user);

    return user;
  }

  @override
  Future<User> signIn(SignInRequest request) async {
    final (user, tokenPair) = await _remoteDataProvider.signIn(request);
    await _localDataProvider.saveTokenPair(tokenPair);
    await _localDataProvider.saveUser(user);

    return user;
  }

  @override
  Future<void> signOut() => _localDataProvider.clear();
}
