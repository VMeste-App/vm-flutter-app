import 'package:dio/dio.dart';
import 'package:vm_app/src/core/model/typedefs.dart';
import 'package:vm_app/src/feature/event/model/event.dart';
import 'package:vm_app/src/feature/favorite/data/favorite_local_data_source.dart';
import 'package:vm_app/src/feature/place/model/place.dart';
import 'package:vm_app/src/feature/profile/model/profile.dart';

typedef IFavoriteRepository$Event = IFavoriteRepository<VmEvent, VmEventId>;
typedef IFavoriteRepository$Profile = IFavoriteRepository<Profile, ProfileId>;
typedef IFavoriteRepository$Place = IFavoriteRepository<Place, PlaceId>;

abstract interface class IFavoriteRepository<Value extends Object, Id extends Object> {
  /// {@template favorite.get}
  /// Получить список избранных.
  /// {@endtemplate}
  Future<List<Value>> get({int page = 1});

  /// {@template favorite.getIds}
  /// Получить список id избранных.
  /// {@endtemplate}
  Future<Set<Id>> getIds();

  /// {@template favorite.add}
  /// Добавить в избранное.
  /// {@endtemplate}
  Future<Set<Id>> add(Id id);

  /// {@template favorite.remove}
  /// Удалить из избранного.
  /// {@endtemplate}
  Future<Set<Id>> remove(Id id);
}

class FavoriteRepository$Event implements IFavoriteRepository$Event {
  final Dio _httpClient;
  final FavoriteLocalDataSource<VmEventId> _localDs;

  FavoriteRepository$Event({
    required Dio httpClient,
    required FavoriteLocalDataSource<VmEventId> localDs,
  }) : _httpClient = httpClient,
       _localDs = localDs;

  @override
  Future<List<VmEvent>> get({int page = 1}) async {
    await _httpClient.get<Json>(
      '/events/favorites',
      queryParameters: {'page': page},
    );
    return [];
  }

  @override
  Future<Set<VmEventId>> getIds() async {
    return _localDs.getIds();
  }

  @override
  Future<Set<VmEventId>> add(VmEventId id) async {
    // await _httpClient.post<Json>('/events/favorite/add/$id');
    return _localDs.add(id);
  }

  @override
  Future<Set<VmEventId>> remove(VmEventId id) async {
    // await _httpClient.post<Json>('/events/favorite/remove/$id');
    return _localDs.remove(id);
  }
}

class FavoriteRepository$Profile implements IFavoriteRepository$Profile {
  final Dio _httpClient;
  final FavoriteLocalDataSource<ProfileId> _localDs;

  FavoriteRepository$Profile({
    required Dio httpClient,
    required FavoriteLocalDataSource<ProfileId> localDs,
  }) : _httpClient = httpClient,
       _localDs = localDs;

  @override
  Future<List<Profile>> get({int page = 1}) async {
    await _httpClient.get<Json>(
      '/profiles/favorites',
      queryParameters: {'page': page},
    );
    return [];
  }

  @override
  Future<Set<ProfileId>> getIds() async {
    return {};
  }

  @override
  Future<Set<ProfileId>> add(VmEventId id) async {
    await _httpClient.post<Json>('/profiles/favorite/add/$id');
    return {};
  }

  @override
  Future<Set<ProfileId>> remove(VmEventId id) async {
    await _httpClient.post<Json>('/profiles/favorite/remove/$id');
    return {};
  }
}

class FavoriteRepository$Place implements IFavoriteRepository$Place {
  final Dio _httpClient;
  final FavoriteLocalDataSource<PlaceId> _localDs;

  FavoriteRepository$Place({
    required Dio httpClient,
    required FavoriteLocalDataSource<PlaceId> localDs,
  }) : _httpClient = httpClient,
       _localDs = localDs;

  @override
  Future<List<Place>> get({int page = 1}) async {
    await _httpClient.get<Json>(
      '/profiles/favorites',
      queryParameters: {'page': page},
    );
    return [];
  }

  @override
  Future<Set<PlaceId>> getIds() async {
    return {};
  }

  @override
  Future<Set<PlaceId>> add(VmEventId id) async {
    await _httpClient.post<Json>('/profiles/favorite/add/$id');
    return {};
  }

  @override
  Future<Set<PlaceId>> remove(VmEventId id) async {
    await _httpClient.post<Json>('/profiles/favorite/remove/$id');
    return {};
  }
}
