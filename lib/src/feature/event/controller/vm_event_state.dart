import 'package:meta/meta.dart';
import 'package:vm_app/src/feature/event/model/event.dart';

@immutable
sealed class VmEventState extends _VmEventStateBase with _VmEventStateShortcuts {
  const VmEventState({super.events = const []});

  const factory VmEventState.idle({List<VmEvent> events}) = VmEventStateIdle;

  const factory VmEventState.processing({List<VmEvent> events}) = VmEventStateProcessing;

  const factory VmEventState.success({List<VmEvent> events}) = VmEventStateSuccess;

  const factory VmEventState.error(Object error, {List<VmEvent> events}) = VmEventStateError;
}

// --- States's helper classes ---
final class VmEventStateIdle extends VmEventState {
  const VmEventStateIdle({super.events});
}

final class VmEventStateProcessing extends VmEventState {
  const VmEventStateProcessing({super.events});
}

final class VmEventStateSuccess extends VmEventState {
  const VmEventStateSuccess({super.events});
}

final class VmEventStateError extends VmEventState {
  const VmEventStateError(this.error, {super.events});

  final Object error;
}

// --- State's shortcuts ---
base mixin _VmEventStateShortcuts on _VmEventStateBase {
  VmEventState processing() => VmEventState.processing(events: events);

  VmEventState errorState(Object error) => VmEventState.error(error, events: events);
}

// --- State's base class ---
@immutable
abstract base class _VmEventStateBase {
  const _VmEventStateBase({this.events = const []});

  final List<VmEvent> events;

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
