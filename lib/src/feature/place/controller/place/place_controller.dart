import 'package:control/control.dart';
import 'package:meta/meta.dart';
import 'package:vm_app/src/feature/place/data/place_repository.dart';
import 'package:vm_app/src/feature/place/model/place.dart';

part 'place_state.dart';

final class PlaceController extends StateController<PlaceState> with SequentialControllerHandler {
  PlaceController({
    required this.id,
    required IPlaceRepository repository,
  }) : _repository = repository,
       super(initialState: const PlaceState.idle()) {
    fetch(id);
  }

  final PlaceId id;
  final IPlaceRepository _repository;

  void fetch(PlaceId id) => handle(
    () async {
      setState(state.processing());
      final place = await _repository.getById(id);
      setState(state.success(place));
    },
    error: (e, _) async => setState(state.errorState(e)),
    done: () async => setState(state.idle()),
  );
}
