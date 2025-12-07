import 'package:meta/meta.dart';

@immutable
sealed class VmEventCreateState extends _VmEventCreateStateBase with _VmEventCreateStateShortcuts {
  const VmEventCreateState();

  const factory VmEventCreateState.idle() = VmEventCreateStateIdle;

  const factory VmEventCreateState.processing() = VmEventCreateStateProcessing;

  const factory VmEventCreateState.success() = VmEventCreateStateSuccess;

  const factory VmEventCreateState.error(Object error) = VmEventCreateStateError;
}

// --- States's helper classes ---
final class VmEventCreateStateIdle extends VmEventCreateState {
  const VmEventCreateStateIdle();
}

final class VmEventCreateStateProcessing extends VmEventCreateState {
  const VmEventCreateStateProcessing();
}

final class VmEventCreateStateSuccess extends VmEventCreateState {
  const VmEventCreateStateSuccess();
}

final class VmEventCreateStateError extends VmEventCreateState {
  const VmEventCreateStateError(this.error);

  final Object error;
}

// --- State's shortcuts ---
base mixin _VmEventCreateStateShortcuts on _VmEventCreateStateBase {
  VmEventCreateState processing() => const VmEventCreateState.processing();

  VmEventCreateState errorState(Object error) => VmEventCreateState.error(error);
}

// --- State's base class ---
@immutable
abstract base class _VmEventCreateStateBase {
  const _VmEventCreateStateBase();

  R map<R>({
    required _VmStateMatch<R, VmEventCreateStateIdle> idle,
    required _VmStateMatch<R, VmEventCreateStateProcessing> processing,
    required _VmStateMatch<R, VmEventCreateStateSuccess> success,
    required _VmStateMatch<R, VmEventCreateStateError> error,
  }) => switch (this) {
    final VmEventCreateStateIdle s => idle(s),
    final VmEventCreateStateProcessing s => processing(s),
    final VmEventCreateStateSuccess s => success(s),
    final VmEventCreateStateError s => error(s),
    _ => throw AssertionError(),
  };

  R maybeMap<R>({
    required R Function() orElse,
    _VmStateMatch<R, VmEventCreateStateIdle>? idle,
    _VmStateMatch<R, VmEventCreateStateProcessing>? processing,
    _VmStateMatch<R, VmEventCreateStateSuccess>? success,
    _VmStateMatch<R, VmEventCreateStateError>? error,
  }) => map<R>(
    idle: idle ?? (_) => orElse(),
    processing: processing ?? (_) => orElse(),
    success: success ?? (_) => orElse(),
    error: error ?? (_) => orElse(),
  );

  R? mapOrNull<R>({
    _VmStateMatch<R, VmEventCreateStateIdle>? idle,
    _VmStateMatch<R, VmEventCreateStateProcessing>? processing,
    _VmStateMatch<R, VmEventCreateStateSuccess>? success,
    _VmStateMatch<R, VmEventCreateStateError>? error,
  }) => map<R?>(
    idle: idle ?? (_) => null,
    processing: processing ?? (_) => null,
    success: success ?? (_) => null,
    error: error ?? (_) => null,
  );
}

// --- Helpers for matching ---
typedef _VmStateMatch<R, S extends VmEventCreateState> = R Function(S state);
