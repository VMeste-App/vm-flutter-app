part of 'search_location_controller.dart';

@immutable
sealed class SearchLocationState extends _SearchLocationStateBase with _SearchLocationStateShortcuts {
  SearchLocationState();

  factory SearchLocationState.idle({required PagedData<Location> locations}) = SearchLocationStateIdle;

  factory SearchLocationState.processing({required PagedData<Location> locations}) = SearchLocationStateProcessing;

  factory SearchLocationState.success({required PagedData<Location> locations}) = SearchLocationStateSuccess;

  factory SearchLocationState.error(Object error, {required PagedData<Location> locations}) = SearchLocationStateError;
}

// --- States's helper classes ---
final class SearchLocationStateIdle extends SearchLocationState {
  SearchLocationStateIdle({required this.locations});

  @override
  final PagedData<Location> locations;
}

final class SearchLocationStateProcessing extends SearchLocationState {
  SearchLocationStateProcessing({required this.locations});

  @override
  final PagedData<Location> locations;
}

final class SearchLocationStateSuccess extends SearchLocationState {
  SearchLocationStateSuccess({required this.locations});

  @override
  final PagedData<Location> locations;
}

final class SearchLocationStateError extends SearchLocationState {
  SearchLocationStateError(
    this.error, {
    required this.locations,
  });

  final Object error;

  @override
  final PagedData<Location> locations;
}

// --- State's shortcuts ---
base mixin _SearchLocationStateShortcuts on _SearchLocationStateBase {
  SearchLocationState idle() => SearchLocationState.idle(locations: locations);

  SearchLocationState processing() => SearchLocationState.processing(locations: locations);

  SearchLocationState errorState(Object error) => SearchLocationState.error(error, locations: locations);

  SearchLocationState success({required PagedData<Location> locations}) =>
      SearchLocationState.success(locations: locations);
}

// --- State's base class ---
@immutable
abstract base class _SearchLocationStateBase {
  const _SearchLocationStateBase();

  abstract final PagedData<Location> locations;
}
