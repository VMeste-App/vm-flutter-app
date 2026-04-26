import 'package:vm_app/src/core/initialization/fake/data/fake_data.dart';
import 'package:vm_app/src/feature/event/model/event.dart';
import 'package:vm_app/src/feature/favorite/data/favorite_local_data_source.dart';
import 'package:vm_app/src/feature/favorite/data/favorite_repository.dart';
import 'package:vm_app/src/feature/place/model/place.dart';
import 'package:vm_app/src/feature/profile/model/profile.dart';

final class FakeFavoriteRepository$Event implements IFavoriteRepository$Event {
  final FavoriteLocalDataSource<VmEventId> _localDs;

  FakeFavoriteRepository$Event({required FavoriteLocalDataSource<VmEventId> localDs}) : _localDs = localDs;

  @override
  Future<List<VmEvent>> get({int page = 1}) async {
    final ids = await getIds();
    return FakeData.events.where((event) => ids.contains(event.id)).toList();
  }

  @override
  Future<Set<VmEventId>> getIds() => _localDs.getIds();

  @override
  Future<Set<VmEventId>> add(VmEventId id) => _localDs.add(id);

  @override
  Future<Set<VmEventId>> remove(VmEventId id) => _localDs.remove(id);
}

final class FakeFavoriteRepository$Profile implements IFavoriteRepository$Profile {
  final FavoriteLocalDataSource<ProfileId> _localDs;

  FakeFavoriteRepository$Profile({required FavoriteLocalDataSource<ProfileId> localDs}) : _localDs = localDs;

  @override
  Future<List<Profile>> get({int page = 1}) async {
    final ids = await getIds();
    return FakeData.profiles.where((profile) => ids.contains(profile.id)).toList();
  }

  @override
  Future<Set<ProfileId>> getIds() => _localDs.getIds();

  @override
  Future<Set<ProfileId>> add(ProfileId id) => _localDs.add(id);

  @override
  Future<Set<ProfileId>> remove(ProfileId id) => _localDs.remove(id);
}

final class FakeFavoriteRepository$Place implements IFavoriteRepository$Place {
  final FavoriteLocalDataSource<PlaceId> _localDs;

  FakeFavoriteRepository$Place({required FavoriteLocalDataSource<PlaceId> localDs}) : _localDs = localDs;

  @override
  Future<List<Place>> get({int page = 1}) async {
    final ids = await getIds();
    return FakeData.places.where((place) => ids.contains(place.id)).toList();
  }

  @override
  Future<Set<PlaceId>> getIds() => _localDs.getIds();

  @override
  Future<Set<PlaceId>> add(PlaceId id) => _localDs.add(id);

  @override
  Future<Set<PlaceId>> remove(PlaceId id) => _localDs.remove(id);
}
