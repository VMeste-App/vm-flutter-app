part of 'place_controller.dart';

@immutable
sealed class PlaceState extends _PlaceStateBase with _PlaceStateShortcuts {
  const PlaceState();

  const factory PlaceState.idle({Place? place}) = PlaceStateIdle;

  const factory PlaceState.processing({Place? place}) = PlaceStateProcessing;

  const factory PlaceState.success(Place place) = PlaceStateSuccess;

  const factory PlaceState.error(Object error, {Place? place}) = PlaceStateError;
}

// --- States's helper classes ---
final class PlaceStateIdle extends PlaceState {
  const PlaceStateIdle({this.place});

  @override
  final Place? place;
}

final class PlaceStateProcessing extends PlaceState {
  const PlaceStateProcessing({this.place});

  @override
  final Place? place;
}

final class PlaceStateSuccess extends PlaceState {
  const PlaceStateSuccess(this.place);

  @override
  final Place place;
}

final class PlaceStateError extends PlaceState {
  const PlaceStateError(
    this.error, {
    this.place,
  });

  final Object error;

  @override
  final Place? place;
}

// --- State's shortcuts ---
base mixin _PlaceStateShortcuts on _PlaceStateBase {
  PlaceState idle() => PlaceState.idle(place: place);

  PlaceState processing() => const PlaceState.processing();

  PlaceState errorState(Object error) => PlaceState.error(error, place: place);

  PlaceState success(Place place) => PlaceState.success(place);
}

// --- State's base class ---
@immutable
abstract base class _PlaceStateBase {
  const _PlaceStateBase();

  abstract final Place? place;

  bool get isLoading => switch (this) {
    PlaceStateProcessing() => true,
    _ => false,
  };
}
