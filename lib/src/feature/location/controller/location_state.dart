import 'package:meta/meta.dart';
import 'package:vm_app/src/feature/location/model/location.dart';

@immutable
sealed class LocationState extends _LocationStateBase with _LocationStateShortcuts {
  const LocationState();

  const factory LocationState.idle({List<Location> locations}) = LocationStateIdle;

  const factory LocationState.processing({List<Location> locations}) = LocationStateProcessing;

  const factory LocationState.success({required List<Location> locations}) = LocationStateSuccess;

  const factory LocationState.error(Object error, {List<Location> locations}) = LocationStateError;
}

// --- States's helper classes ---
final class LocationStateIdle extends LocationState {
  const LocationStateIdle({
    this.locations = const [],
  });

  @override
  final List<Location> locations;
}

final class LocationStateProcessing extends LocationState {
  const LocationStateProcessing({
    this.locations = const [],
  });

  @override
  final List<Location> locations;
}

final class LocationStateSuccess extends LocationState {
  const LocationStateSuccess({
    required this.locations,
  });

  @override
  final List<Location> locations;
}

final class LocationStateError extends LocationState {
  const LocationStateError(
    this.error, {
    this.locations = const [],
  });

  final Object error;

  @override
  final List<Location> locations;
}

// --- State's shortcuts ---
base mixin _LocationStateShortcuts on _LocationStateBase {
  LocationState idle() => LocationState.idle(locations: locations);

  LocationState processing() => const LocationState.processing();

  LocationState errorState(Object error) => LocationState.error(error, locations: locations);

  LocationState success({required List<Location> locations}) => LocationState.success(locations: locations);
}

// --- State's base class ---
@immutable
abstract base class _LocationStateBase {
  const _LocationStateBase();

  abstract final List<Location> locations;

  bool get isLoading => maybeMap<bool>(processing: (_) => true, orElse: () => false);

  R map<R>({
    required _LocationStateMatch<R, LocationStateIdle> idle,
    required _LocationStateMatch<R, LocationStateProcessing> processing,
    required _LocationStateMatch<R, LocationStateSuccess> success,
    required _LocationStateMatch<R, LocationStateError> error,
  }) => switch (this) {
    final LocationStateIdle s => idle(s),
    final LocationStateProcessing s => processing(s),
    final LocationStateSuccess s => success(s),
    final LocationStateError s => error(s),
    _ => throw AssertionError(),
  };

  R maybeMap<R>({
    required R Function() orElse,
    _LocationStateMatch<R, LocationStateIdle>? idle,
    _LocationStateMatch<R, LocationStateProcessing>? processing,
    _LocationStateMatch<R, LocationStateSuccess>? success,
    _LocationStateMatch<R, LocationStateError>? error,
  }) => map<R>(
    idle: idle ?? (_) => orElse(),
    processing: processing ?? (_) => orElse(),
    success: success ?? (_) => orElse(),
    error: error ?? (_) => orElse(),
  );

  R? mapOrNull<R>({
    _LocationStateMatch<R, LocationStateIdle>? idle,
    _LocationStateMatch<R, LocationStateProcessing>? processing,
    _LocationStateMatch<R, LocationStateSuccess>? success,
    _LocationStateMatch<R, LocationStateError>? error,
  }) => map<R?>(
    idle: idle ?? (_) => null,
    processing: processing ?? (_) => null,
    success: success ?? (_) => null,
    error: error ?? (_) => null,
  );
}

// --- Helpers for matching ---
typedef _LocationStateMatch<R, S extends LocationState> = R Function(S state);
