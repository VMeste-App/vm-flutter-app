import 'package:control/control.dart';
import 'package:vm_app/src/feature/location/controller/location_state.dart';
import 'package:vm_app/src/feature/location/data/location_repository.dart';
import 'package:vm_app/src/feature/location/model/location_filter.dart';

final class LocationController extends StateController<LocationState> with SequentialControllerHandler {
  LocationController({
    required ILocationRepository repository,
  }) : _repository = repository,
       super(initialState: const LocationState.idle());

  final ILocationRepository _repository;

  void fetch() => handle(
    () async {
      setState(state.processing());
      final locations = await _repository.fetch(const LocationFilter());
      setState(state.success(locations: locations));
    },
    error: (e, _) async => setState(state.errorState(e)),
    done: () async => setState(state.idle()),
  );
}
