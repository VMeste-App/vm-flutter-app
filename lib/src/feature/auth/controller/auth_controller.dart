import 'package:control/control.dart';
import 'package:meta/meta.dart';
import 'package:vm_app/src/feature/auth/data/auth_repository.dart';
import 'package:vm_app/src/feature/auth/model/authentication_status.dart';
import 'package:vm_app/src/feature/auth/model/sign_up_request.dart';

final class AuthController extends StateController<AuthState> with ConcurrentControllerHandler {
  AuthController({required IAuthRepository authRepository, AuthenticationStatus? initialStatus})
    : _authRepository = authRepository,
      super(initialState: AuthState.idle(status: initialStatus ?? AuthenticationStatus.unauthenticated));

  final IAuthRepository _authRepository;

  void signUp(String login, String password) => handle(
    () async {
      setState(AuthState.processing(status: state.status));
      final request = SignUpRequest(username: login, password: password);
      await _authRepository.signUp(request);
      setState(const AuthState.idle(status: AuthenticationStatus.authenticated));
    },
    error: (e, _) async {
      setState(AuthState.idle(status: state.status, error: e));
    },
  );

  void signIn(String login, String password) => handle(
    () async {
      setState(AuthState.processing(status: state.status));
      await Future.microtask(() {});
      // final request = SignInRequest(username: login, password: password);
      // await _authRepository.signIn(request);
      setState(const AuthState.idle(status: AuthenticationStatus.authenticated));
    },
    error: (e, _) async {
      setState(AuthState.idle(status: state.status, error: e));
    },
  );

  void signOut() => handle(
    () async {
      setState(AuthState.processing(status: state.status));
      await _authRepository.signOut();
      setState(const AuthState.idle(status: AuthenticationStatus.unauthenticated));
    },
    error: (e, _) async {
      setState(AuthState.idle(status: state.status, error: e));
    },
  );
}

sealed class AuthState extends _AuthStateBase {
  const AuthState({required super.status});

  const factory AuthState.idle({required AuthenticationStatus status, Object? error}) = AuthStateIdle;

  const factory AuthState.processing({required AuthenticationStatus status}) = AuthStateProcessing;
}

final class AuthStateIdle extends AuthState {
  const AuthStateIdle({required super.status, this.error});

  @override
  final Object? error;
}

final class AuthStateProcessing extends AuthState {
  const AuthStateProcessing({required super.status});

  @override
  String? get error => null;
}

@immutable
abstract base class _AuthStateBase {
  const _AuthStateBase({required this.status});

  @nonVirtual
  final AuthenticationStatus status;

  /// Error object.
  abstract final Object? error;

  /// If an error has occurred?
  bool get hasError => error != null;

  /// Is in progress state?
  bool get isProcessing => maybeMap<bool>(orElse: () => false, processing: (_) => true);

  /// Is in idle state?
  bool get isIdling => !isProcessing;

  bool get authenticated => status == AuthenticationStatus.authenticated;

  /// Pattern matching for [AuthState].
  R map<R>({
    required _AuthStateMatch<R, AuthStateIdle> idle,
    required _AuthStateMatch<R, AuthStateProcessing> processing,
  }) => switch (this) {
    final AuthStateIdle s => idle(s),
    final AuthStateProcessing s => processing(s),
    _ => throw AssertionError(),
  };

  /// Pattern matching for [AuthState].
  R maybeMap<R>({
    required R Function() orElse,
    _AuthStateMatch<R, AuthStateIdle>? idle,
    _AuthStateMatch<R, AuthStateProcessing>? processing,
  }) => map<R>(idle: idle ?? (_) => orElse(), processing: processing ?? (_) => orElse());

  /// Pattern matching for [AuthState].
  R? mapOrNull<R>({_AuthStateMatch<R, AuthStateIdle>? idle, _AuthStateMatch<R, AuthStateProcessing>? processing}) =>
      map<R?>(idle: idle ?? (_) => null, processing: processing ?? (_) => null);

  @override
  String toString() {
    final buffer =
        StringBuffer()
          ..write('AuthState(')
          ..write('status: $status');
    if (error != null) buffer.write(', error: $error');
    buffer.write(')');

    return buffer.toString();
  }
}

/// Pattern matching for [AuthState].
typedef _AuthStateMatch<R, S extends AuthState> = R Function(S state);
