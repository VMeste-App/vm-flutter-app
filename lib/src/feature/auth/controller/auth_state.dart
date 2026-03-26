// ignore_for_file: library_private_types_in_public_api

part of 'auth_controller.dart';

sealed class AuthenticationState extends _AuthStateBase with _AuthStateShortcuts {
  const AuthenticationState({super.user});

  const factory AuthenticationState.idle({User? user}) = _AuthStateIdle;

  const factory AuthenticationState.processing({User? user}) = _AuthStateProcessing;

  const factory AuthenticationState.success({User? user}) = _AuthStateSuccess;

  const factory AuthenticationState.error(Object error, {User? user}) = _AuthStateError;
}

// --- States's helper classes ---
final class _AuthStateIdle extends AuthenticationState {
  const _AuthStateIdle({super.user});
}

final class _AuthStateProcessing extends AuthenticationState {
  const _AuthStateProcessing({super.user});
}

final class _AuthStateError extends AuthenticationState {
  const _AuthStateError(this.error, {super.user});

  final Object error;
}

final class _AuthStateSuccess extends AuthenticationState {
  const _AuthStateSuccess({super.user});
}

// --- State's shortcuts ---
base mixin _AuthStateShortcuts on _AuthStateBase {
  AuthenticationState idle({User? user}) => AuthenticationState.idle(user: user ?? this.user);

  AuthenticationState authenticated(User user) => AuthenticationState.success(user: user);

  AuthenticationState unauthenticated() => const AuthenticationState.success();

  AuthenticationState processing() => AuthenticationState.processing(user: user);

  AuthenticationState errorState(Object error) => AuthenticationState.error(error, user: user);
}

// --- State's base class ---
@immutable
abstract base class _AuthStateBase {
  const _AuthStateBase({this.user});

  final User? user;
}

extension AuthStateX on AuthenticationState {
  bool get isAuthenticated => user != null;

  /// Is in progress state?
  bool get isProcessing => switch (this) {
    _AuthStateProcessing() => true,
    _ => false,
  };

  /// Is in idle state?
  bool get isIdling => !isProcessing;

  /// Is in error state?
  bool get isError => switch (this) {
    _AuthStateError() => true,
    _ => false,
  };
}

// --- Helpers for matching ---
typedef AuthStateMatch<R, S extends AuthenticationState> = R Function(S state);
