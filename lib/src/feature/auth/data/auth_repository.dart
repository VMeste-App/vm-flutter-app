import 'package:vm_app/src/feature/auth/data/auth_data_provider.dart';

abstract interface class IAuthRepository {
  Future<void> signIn();

  Future<void> signOut();
}

final class AuthRepository implements IAuthRepository {
  const AuthRepository({required IAuthDataProvider dataProvider}) : _dataProvider = dataProvider;

  final IAuthDataProvider _dataProvider;

  @override
  Future<void> signIn() => _dataProvider.signIn();

  @override
  Future<void> signOut() => _dataProvider.signOut();
}
