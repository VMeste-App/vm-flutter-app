import 'package:control/control.dart';
import 'package:meta/meta.dart';
import 'package:vm_app/src/feature/location/data/location_repository.dart';
import 'package:vm_app/src/feature/location/model/location.dart';

part 'location_state.dart';

final class LocationController extends StateController<LocationState> with SequentialControllerHandler {
  LocationController(
    this._id, {
    required ILocationRepository repository,
  }) : _repository = repository,
       super(initialState: const LocationState.idle()) {
    fetch(_id);
  }

  final LocationId _id;
  final ILocationRepository _repository;

  void fetch(LocationId id) => handle(
    () async {
      setState(state.processing());
      final location = await _repository.fetchById(id);
      setState(state.success(location));
    },
    error: (e, _) async => setState(state.errorState(e)),
    done: () async => setState(state.idle()),
  );
}
