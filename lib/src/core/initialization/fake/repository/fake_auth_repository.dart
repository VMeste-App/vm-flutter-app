import 'package:vm_app/src/core/initialization/fake/data/fake_data.dart';
import 'package:vm_app/src/feature/auth/data/auth_repository.dart';
import 'package:vm_app/src/feature/auth/model/request/sign_in_request.dart';
import 'package:vm_app/src/feature/auth/model/request/sign_up_request.dart';
import 'package:vm_app/src/feature/auth/model/user.dart';

final class FakeAuthRepository implements IAuthRepository {
  @override
  Future<User?> restore() => Future.value(FakeData.user);

  @override
  Future<User> signUp(SignUpRequest request) => Future.value(FakeData.user);

  @override
  Future<User> signIn(SignInRequest request) => Future.value(FakeData.user);

  @override
  Future<void> signOut() => Future.value();

  @override
  Future<void> deleteAccount() => Future.value();
}
