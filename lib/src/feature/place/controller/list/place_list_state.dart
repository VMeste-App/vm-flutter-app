part of 'place_list_controller.dart';

@immutable
sealed class SearchLocationState extends _SearchLocationStateBase with _SearchLocationStateShortcuts {
  SearchLocationState();

  factory SearchLocationState.idle({required List<Place> locations}) = SearchLocationStateIdle;

  factory SearchLocationState.processing({required List<Place> locations}) = SearchLocationStateProcessing;

  factory SearchLocationState.success({required List<Place> locations}) = SearchLocationStateSuccess;

  factory SearchLocationState.error(Object error, {required List<Place> locations}) = SearchLocationStateError;
}

// --- States's helper classes ---
final class SearchLocationStateIdle extends SearchLocationState {
  SearchLocationStateIdle({required this.locations});

  @override
  final List<Place> locations;
}

final class SearchLocationStateProcessing extends SearchLocationState {
  SearchLocationStateProcessing({required this.locations});

  @override
  final List<Place> locations;
}

final class SearchLocationStateSuccess extends SearchLocationState {
  SearchLocationStateSuccess({required this.locations});

  @override
  final List<Place> locations;
}

final class SearchLocationStateError extends SearchLocationState {
  SearchLocationStateError(
    this.error, {
    required this.locations,
  });

  final Object error;

  @override
  final List<Place> locations;
}

// --- State's shortcuts ---
base mixin _SearchLocationStateShortcuts on _SearchLocationStateBase {
  SearchLocationState idle() => SearchLocationState.idle(locations: locations);

  SearchLocationState processing() => SearchLocationState.processing(locations: locations);

  SearchLocationState errorState(Object error) => SearchLocationState.error(error, locations: locations);

  SearchLocationState success({required List<Place> locations}) => SearchLocationState.success(locations: locations);
}

// --- State's base class ---
@immutable
abstract base class _SearchLocationStateBase {
  const _SearchLocationStateBase();

  abstract final List<Place> locations;
}
