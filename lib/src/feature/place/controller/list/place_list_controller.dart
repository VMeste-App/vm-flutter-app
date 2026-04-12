import 'package:control/control.dart';
import 'package:meta/meta.dart';
import 'package:vm_app/src/core/model/paged_data.dart';
import 'package:vm_app/src/feature/place/data/place_repository.dart';
import 'package:vm_app/src/feature/place/model/place.dart';
import 'package:vm_app/src/feature/place/model/place_filter.dart';

part 'place_list_state.dart';

final class PlaceListController extends StateController<SearchLocationState> with SequentialControllerHandler {
  PlaceListController({
    required IPlaceRepository repository,
  }) : _repository = repository,
       super(initialState: SearchLocationState.idle(locations: PagedData<Place>.empty()));

  final IPlaceRepository _repository;

  void fetch(PlaceFilter filter) => handle(
    () async {
      setState(state.processing());
      final places = await _repository.getPlaces(filter);
      setState(state.success(locations: places));
    },
    error: (e, _) async => setState(state.errorState(e)),
    done: () async => setState(state.idle()),
  );
}
