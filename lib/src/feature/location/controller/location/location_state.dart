part of 'location_controller.dart';

@immutable
sealed class LocationState extends _LocationStateBase with _LocationStateShortcuts {
  const LocationState();

  const factory LocationState.idle({Location? location}) = LocationStateIdle;

  const factory LocationState.processing({Location? location}) = LocationStateProcessing;

  const factory LocationState.success(Location location) = LocationStateSuccess;

  const factory LocationState.error(Object error, {Location? location}) = LocationStateError;
}

// --- States's helper classes ---
final class LocationStateIdle extends LocationState {
  const LocationStateIdle({this.location});

  @override
  final Location? location;
}

final class LocationStateProcessing extends LocationState {
  const LocationStateProcessing({this.location});

  @override
  final Location? location;
}

final class LocationStateSuccess extends LocationState {
  const LocationStateSuccess(this.location);

  @override
  final Location location;
}

final class LocationStateError extends LocationState {
  const LocationStateError(
    this.error, {
    this.location,
  });

  final Object error;

  @override
  final Location? location;
}

// --- State's shortcuts ---
base mixin _LocationStateShortcuts on _LocationStateBase {
  LocationState idle() => LocationState.idle(location: location);

  LocationState processing() => const LocationState.processing();

  LocationState errorState(Object error) => LocationState.error(error, location: location);

  LocationState success(Location location) => LocationState.success(location);
}

// --- State's base class ---
@immutable
abstract base class _LocationStateBase {
  const _LocationStateBase();

  abstract final Location? location;

  bool get isLoading => switch (this) {
    LocationStateProcessing() => true,
    _ => false,
  };
}
