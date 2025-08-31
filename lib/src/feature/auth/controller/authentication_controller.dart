import 'package:control/control.dart';
import 'package:meta/meta.dart';
import 'package:vm_app/src/feature/auth/data/auth_repository.dart';
import 'package:vm_app/src/feature/auth/model/request/sign_in_request.dart';
import 'package:vm_app/src/feature/auth/model/request/sign_up_request.dart';
import 'package:vm_app/src/feature/auth/model/user.dart';

part 'authentication_state.dart';

final class AuthController extends StateController<AuthenticationState> with ConcurrentControllerHandler {
  AuthController({
    required IAuthRepository authRepository,
    User? user,
  }) : _authRepository = authRepository,
       super(initialState: AuthenticationState.idle(user: user));

  final IAuthRepository _authRepository;

  void signUp(String email, String password) => handle(
    () async {
      setState(state.processing());
      final request = SignUpRequest(email: email, password: password);
      final user = await _authRepository.signUp(request);
      setState(state.authenticated(user));
    },
    error: (e, st) async => setState(state.errorState(e)),
    done: () async => setState(state.idle()),
  );

  void signIn(String email, String password) => handle(
    () async {
      setState(state.processing());
      final request = SignInRequest(email: email, password: password);
      final user = await _authRepository.signIn(request);
      setState(state.authenticated(user));
    },
    error: (e, st) async => setState(state.errorState(e)),
    done: () async => setState(state.idle()),
  );

  void signOut() => handle(
    () async {
      setState(state.processing());
      await _authRepository.signOut();
      setState(state.unauthenticated());
    },
    error: (e, st) async => setState(state.errorState(e)),
    done: () async => setState(state.idle()),
  );
}
