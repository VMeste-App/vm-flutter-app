abstract interface class IAuthDataProvider {
  Future<void> signIn();

  Future<void> signOut();
}

final class AuthDataProvider implements IAuthDataProvider {
  AuthDataProvider();

  @override
  Future<void> signIn() async {}

  @override
  Future<void> signOut() async {}
}
