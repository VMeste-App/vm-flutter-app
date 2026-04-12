import 'package:meta/meta.dart';
import 'package:vm_app/src/feature/event/model/event.dart';

@immutable
sealed class VmEventState extends _VmEventStateBase with _VmEventStateShortcuts {
  const VmEventState({super.event});

  const factory VmEventState.idle({VmEvent? event}) = VmEventStateIdle;

  const factory VmEventState.processing({VmEvent? event}) = VmEventStateProcessing;

  const factory VmEventState.success({VmEvent event}) = VmEventStateSuccess;

  const factory VmEventState.error(Object error, {VmEvent? event}) = VmEventStateError;
}

// --- States's helper classes ---
final class VmEventStateIdle extends VmEventState {
  const VmEventStateIdle({super.event});
}

final class VmEventStateProcessing extends VmEventState {
  const VmEventStateProcessing({super.event});
}

final class VmEventStateSuccess extends VmEventState {
  const VmEventStateSuccess({super.event});
}

final class VmEventStateError extends VmEventState {
  const VmEventStateError(this.error, {super.event});

  final Object error;
}

// --- State's shortcuts ---
base mixin _VmEventStateShortcuts on _VmEventStateBase {
  VmEventState idle() => VmEventState.idle(event: event);

  VmEventState processing() => VmEventState.processing(event: event);

  VmEventState success(VmEvent event) => VmEventState.success(event: event);

  VmEventState errorState(Object error) => VmEventState.error(error, event: event);
}

// --- State's base class ---
@immutable
abstract base class _VmEventStateBase {
  const _VmEventStateBase({this.event});

  final VmEvent? event;

  R map<R>({
    required _VmStateMatch<R, VmEventStateIdle> idle,
    required _VmStateMatch<R, VmEventStateProcessing> processing,
    required _VmStateMatch<R, VmEventStateSuccess> success,
    required _VmStateMatch<R, VmEventStateError> error,
  }) => switch (this) {
    final VmEventStateIdle s => idle(s),
    final VmEventStateProcessing s => processing(s),
    final VmEventStateSuccess s => success(s),
    final VmEventStateError s => error(s),
    _ => throw AssertionError(),
  };

  R maybeMap<R>({
    required R Function() orElse,
    _VmStateMatch<R, VmEventStateIdle>? idle,
    _VmStateMatch<R, VmEventStateProcessing>? processing,
    _VmStateMatch<R, VmEventStateSuccess>? success,
    _VmStateMatch<R, VmEventStateError>? error,
  }) => map<R>(
    idle: idle ?? (_) => orElse(),
    processing: processing ?? (_) => orElse(),
    success: success ?? (_) => orElse(),
    error: error ?? (_) => orElse(),
  );

  R? mapOrNull<R>({
    _VmStateMatch<R, VmEventStateIdle>? idle,
    _VmStateMatch<R, VmEventStateProcessing>? processing,
    _VmStateMatch<R, VmEventStateSuccess>? success,
    _VmStateMatch<R, VmEventStateError>? error,
  }) => map<R?>(
    idle: idle ?? (_) => null,
    processing: processing ?? (_) => null,
    success: success ?? (_) => null,
    error: error ?? (_) => null,
  );
}

// --- Helpers for matching ---
typedef _VmStateMatch<R, S extends VmEventState> = R Function(S state);
