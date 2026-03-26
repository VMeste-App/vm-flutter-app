import 'package:control/control.dart';
import 'package:meta/meta.dart';
import 'package:vm_app/src/core/model/paged_data.dart';
import 'package:vm_app/src/feature/location/data/location_repository.dart';
import 'package:vm_app/src/feature/location/model/location.dart';
import 'package:vm_app/src/feature/location/model/location_filter.dart';

part 'search_location_state.dart';

final class SearchLocationController extends StateController<SearchLocationState> with SequentialControllerHandler {
  SearchLocationController({
    required ILocationRepository repository,
  }) : _repository = repository,
       super(initialState: SearchLocationState.idle(locations: PagedData<Location>.empty()));

  final ILocationRepository _repository;

  void fetch(LocationFilter filter) => handle(
    () async {
      setState(state.processing());
      final locations = await _repository.fetch(filter);
      setState(state.success(locations: locations));
    },
    error: (e, _) async => setState(state.errorState(e)),
    done: () async => setState(state.idle()),
  );
}
