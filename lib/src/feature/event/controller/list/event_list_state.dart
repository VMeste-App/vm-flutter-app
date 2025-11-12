import 'package:meta/meta.dart';
import 'package:vm_app/src/feature/event/model/event.dart';
import 'package:vm_app/src/feature/event/model/scroll_state.dart';

@immutable
sealed class EventListState extends _EventListStateBase with _EventListStateShortcuts {
  const EventListState({
    super.events = const [],
    super.scrollState = const ScrollState.start(),
  });

  const factory EventListState.idle({
    List<VmEvent> events,
    ScrollState scrollState,
  }) = EventListStateIdle;

  const factory EventListState.processing({
    List<VmEvent> events,
    ScrollState scrollState,
  }) = EventListStateProcessing;

  const factory EventListState.success({
    List<VmEvent> events,
    ScrollState scrollState,
  }) = EventListStateSuccess;

  const factory EventListState.error(
    Object error, {
    List<VmEvent> events,
    ScrollState scrollState,
  }) = EventListStateError;
}

// --- States's helper classes ---
final class EventListStateIdle extends EventListState {
  const EventListStateIdle({
    super.events,
    super.scrollState,
  });
}

final class EventListStateProcessing extends EventListState {
  const EventListStateProcessing({
    super.events,
    super.scrollState,
  });
}

final class EventListStateSuccess extends EventListState {
  const EventListStateSuccess({
    super.events,
    super.scrollState,
  });
}

final class EventListStateError extends EventListState {
  const EventListStateError(
    this.error, {
    super.events,
    super.scrollState,
  });

  final Object error;
}

// --- State's shortcuts ---
base mixin _EventListStateShortcuts on _EventListStateBase {
  EventListState processing() => EventListState.processing(events: events, scrollState: scrollState);

  EventListState errorState(Object error) => EventListState.error(error, events: events, scrollState: scrollState);
}

// --- State's base class ---
@immutable
abstract base class _EventListStateBase {
  const _EventListStateBase({
    this.events = const [],
    this.scrollState = const ScrollState.start(),
  });

  final List<VmEvent> events;
  final ScrollState scrollState;

  R map<R>({
    required _EventListStateMatch<R, EventListStateIdle> idle,
    required _EventListStateMatch<R, EventListStateProcessing> processing,
    required _EventListStateMatch<R, EventListStateSuccess> success,
    required _EventListStateMatch<R, EventListStateError> error,
  }) => switch (this) {
    final EventListStateIdle s => idle(s),
    final EventListStateProcessing s => processing(s),
    final EventListStateSuccess s => success(s),
    final EventListStateError s => error(s),
    _ => throw AssertionError(),
  };

  R maybeMap<R>({
    required R Function() orElse,
    _EventListStateMatch<R, EventListStateIdle>? idle,
    _EventListStateMatch<R, EventListStateProcessing>? processing,
    _EventListStateMatch<R, EventListStateSuccess>? success,
    _EventListStateMatch<R, EventListStateError>? error,
  }) => map<R>(
    idle: idle ?? (_) => orElse(),
    processing: processing ?? (_) => orElse(),
    success: success ?? (_) => orElse(),
    error: error ?? (_) => orElse(),
  );

  R? mapOrNull<R>({
    _EventListStateMatch<R, EventListStateIdle>? idle,
    _EventListStateMatch<R, EventListStateProcessing>? processing,
    _EventListStateMatch<R, EventListStateSuccess>? success,
    _EventListStateMatch<R, EventListStateError>? error,
  }) => map<R?>(
    idle: idle ?? (_) => null,
    processing: processing ?? (_) => null,
    success: success ?? (_) => null,
    error: error ?? (_) => null,
  );
}

// --- Helpers for matching ---
typedef _EventListStateMatch<R, S extends EventListState> = R Function(S state);
