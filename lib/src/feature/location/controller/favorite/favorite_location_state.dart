import 'package:meta/meta.dart';
import 'package:vm_app/src/feature/location/model/location.dart';

@immutable
sealed class FavoriteLocationState extends _LocationStateBase with _LocationStateShortcuts {
  const FavoriteLocationState();

  const factory FavoriteLocationState.idle({Set<LocationId> locations}) = FavoriteLocationStateIdle;

  const factory FavoriteLocationState.processing({Set<LocationId> locations}) = FavoriteLocationStateProcessing;

  const factory FavoriteLocationState.success({required Set<LocationId> locations}) = FavoriteLocationStateSuccess;

  const factory FavoriteLocationState.error(Object error, {Set<LocationId> locations}) = FavoriteLocationStateError;
}

// --- States's helper classes ---
final class FavoriteLocationStateIdle extends FavoriteLocationState {
  const FavoriteLocationStateIdle({
    this.locations = const {},
  });

  @override
  final Set<LocationId> locations;
}

final class FavoriteLocationStateProcessing extends FavoriteLocationState {
  const FavoriteLocationStateProcessing({
    this.locations = const {},
  });

  @override
  final Set<LocationId> locations;
}

final class FavoriteLocationStateSuccess extends FavoriteLocationState {
  const FavoriteLocationStateSuccess({
    required this.locations,
  });

  @override
  final Set<LocationId> locations;
}

final class FavoriteLocationStateError extends FavoriteLocationState {
  const FavoriteLocationStateError(
    this.error, {
    this.locations = const {},
  });

  final Object error;

  @override
  final Set<LocationId> locations;
}

// --- State's shortcuts ---
base mixin _LocationStateShortcuts on _LocationStateBase {
  FavoriteLocationState idle() => FavoriteLocationState.idle(locations: locations);

  FavoriteLocationState processing() => const FavoriteLocationState.processing();

  FavoriteLocationState errorState(Object error) => FavoriteLocationState.error(error, locations: locations);

  FavoriteLocationState success({required Set<LocationId> locations}) =>
      FavoriteLocationState.success(locations: locations);
}

// --- State's base class ---
@immutable
abstract base class _LocationStateBase {
  const _LocationStateBase();

  abstract final Set<LocationId> locations;

  bool get isLoading => switch (this) {
    FavoriteLocationStateProcessing() => true,
    _ => false,
  };
}
