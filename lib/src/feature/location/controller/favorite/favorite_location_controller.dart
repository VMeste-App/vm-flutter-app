import 'package:control/control.dart';
import 'package:meta/meta.dart';
import 'package:vm_app/src/feature/location/data/location_repository.dart';
import 'package:vm_app/src/feature/location/model/location.dart';

part 'favorite_location_state.dart';

final class FavoriteLocationController extends StateController<FavoriteLocationState> with SequentialControllerHandler {
  FavoriteLocationController({
    required ILocationRepository repository,
  }) : _repository = repository,
       super(initialState: const FavoriteLocationState.idle());

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

  void add(LocationId locationId) => handle(
    () async {
      setState(state.processing());
      await _repository.addFavorite(locationId);
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
