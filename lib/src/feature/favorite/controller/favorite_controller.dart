import 'package:meta/meta.dart';
import 'package:vm_app/src/core/controller/controller.dart';
import 'package:vm_app/src/feature/event/model/event.dart';
import 'package:vm_app/src/feature/favorite/data/favorite_repository.dart';
import 'package:vm_app/src/feature/place/model/place.dart';
import 'package:vm_app/src/feature/profile/model/profile.dart';

part 'favorite_state.dart';

typedef FavoriteController$Event = FavoriteController<VmEvent, VmEventId>;
typedef FavoriteController$Profile = FavoriteController<Profile, ProfileId>;
typedef FavoriteController$Place = FavoriteController<Place, PlaceId>;

final class FavoriteController<V extends Object, Id extends Object> extends VmController<FavoriteState<V, Id>> {
  FavoriteController({
    required IFavoriteRepository<V, Id> repository,
  }) : _repository = repository,
       super(
         initialState: FavoriteState<V, Id>.idle(ids: const {}, values: const []),
       );

  final IFavoriteRepository<V, Id> _repository;

  void init() => handle(
    () async {
      setState(state.processing());
      final favoriteIds = await _repository.getIds();
      setState(state.idle(ids: favoriteIds, values: state.values));
    },
    // error: (e, st) async => setState(state.errorState(e)),
    done: () async => setState(state.idle()),
  );

  void fetch({int page = 1}) => handle(
    () async {
      setState(state.processing());
      final favorites = await _repository.get();
      setState(state.idle(values: favorites));
    },
    error: (e, st) async => setState(state.errorState(e)),
    done: () async => setState(state.idle()),
  );

  void add(Id id) => handle(
    () async {
      setState(state.processing());
      final favoriteIds = await _repository.add(id);
      setState(state.success(ids: favoriteIds));
    },
    error: (e, st) async => setState(state.errorState(e)),
    done: () async => setState(state.idle()),
  );

  void remove(Id id) => handle(
    () async {
      setState(state.processing());
      final favoriteIds = await _repository.remove(id);
      setState(state.success(ids: favoriteIds));
    },
    error: (e, st) async => setState(state.errorState(e)),
    done: () async => setState(state.idle()),
  );
}
