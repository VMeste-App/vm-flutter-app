import 'package:control/control.dart';
import 'package:vm_app/src/feature/location/controller/location_state.dart';
import 'package:vm_app/src/feature/location/data/location_repository.dart';
import 'package:vm_app/src/feature/location/model/location.dart';

final class FavoriteLocationController extends StateController<LocationState> with SequentialControllerHandler {
  FavoriteLocationController({
    required ILocationRepository repository,
  }) : _repository = repository,
       super(initialState: const LocationState.idle());

  final ILocationRepository _repository;

  void fetch() => handle(
    () async {
      setState(state.processing());
      final locations = await _repository.fetchFavorites();
      setState(state.success(locations: locations));
    },
    error: (e, _) async => setState(state.errorState(e)),
    done: () async => setState(state.idle()),
  );

  void add(Location location) => handle(
    () async {
      setState(state.processing());
      await _repository.addFavorite(location);
      setState(state.success(locations: state.locations));
    },
    error: (e, _) async => setState(state.errorState(e)),
    done: () async => setState(state.idle()),
  );

  void remove(LocationId id) => handle(
    () async {
      setState(state.processing());
      await _repository.removeFavorite(id);
      setState(state.success(locations: state.locations));
    },
    error: (e, _) async => setState(state.errorState(e)),
    done: () async => setState(state.idle()),
  );
}
