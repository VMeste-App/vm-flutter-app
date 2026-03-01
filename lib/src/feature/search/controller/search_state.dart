import 'package:meta/meta.dart';
import 'package:vm_app/src/feature/event/model/event.dart';
import 'package:vm_app/src/feature/event/model/scroll_state.dart';

@immutable
sealed class SearchState extends _SearchStateBase with _SearchStateShortcuts {
  const SearchState({
    super.events = const [],
    super.scrollState = const ScrollState.start(),
  });

  const factory SearchState.idle({
    List<VmEvent> events,
    ScrollState scrollState,
  }) = EventListStateIdle;

  const factory SearchState.processing({
    List<VmEvent> events,
    ScrollState scrollState,
  }) = EventListStateLoading;

  const factory SearchState.success({
    List<VmEvent> events,
    ScrollState scrollState,
  }) = EventListStateSuccess;

  const factory SearchState.error(
    Object error, {
    List<VmEvent> events,
    ScrollState scrollState,
  }) = EventListStateError;
}

// --- States's helper classes ---
final class EventListStateIdle extends SearchState {
  const EventListStateIdle({
    super.events,
    super.scrollState,
  });
}

final class EventListStateLoading extends SearchState {
  const EventListStateLoading({
    super.events,
    super.scrollState,
  });
}

final class EventListStateSuccess extends SearchState {
  const EventListStateSuccess({
    super.events,
    super.scrollState,
  });
}

final class EventListStateError extends SearchState {
  const EventListStateError(
    this.error, {
    super.events,
    super.scrollState,
  });

  final Object error;
}

// --- State's shortcuts ---
base mixin _SearchStateShortcuts on _SearchStateBase {
  SearchState processing() => SearchState.processing(events: events, scrollState: scrollState);

  SearchState errorState(Object error) => SearchState.error(error, events: events, scrollState: scrollState);
}

// --- State's base class ---
@immutable
abstract base class _SearchStateBase {
  const _SearchStateBase({
    this.events = const [],
    this.scrollState = const ScrollState.start(),
  });

  final List<VmEvent> events;
  final ScrollState scrollState;

  R map<R>({
    required _SearchStateMatch<R, EventListStateIdle> idle,
    required _SearchStateMatch<R, EventListStateLoading> processing,
    required _SearchStateMatch<R, EventListStateSuccess> success,
    required _SearchStateMatch<R, EventListStateError> error,
  }) => switch (this) {
    final EventListStateIdle s => idle(s),
    final EventListStateLoading s => processing(s),
    final EventListStateSuccess s => success(s),
    final EventListStateError s => error(s),
    _ => throw AssertionError(),
  };

  R maybeMap<R>({
    required R Function() orElse,
    _SearchStateMatch<R, EventListStateIdle>? idle,
    _SearchStateMatch<R, EventListStateLoading>? processing,
    _SearchStateMatch<R, EventListStateSuccess>? success,
    _SearchStateMatch<R, EventListStateError>? error,
  }) => map<R>(
    idle: idle ?? (_) => orElse(),
    processing: processing ?? (_) => orElse(),
    success: success ?? (_) => orElse(),
    error: error ?? (_) => orElse(),
  );

  R? mapOrNull<R>({
    _SearchStateMatch<R, EventListStateIdle>? idle,
    _SearchStateMatch<R, EventListStateLoading>? processing,
    _SearchStateMatch<R, EventListStateSuccess>? success,
    _SearchStateMatch<R, EventListStateError>? error,
  }) => map<R?>(
    idle: idle ?? (_) => null,
    processing: processing ?? (_) => null,
    success: success ?? (_) => null,
    error: error ?? (_) => null,
  );
}

// --- Helpers for matching ---
typedef _SearchStateMatch<R, S extends SearchState> = R Function(S state);
