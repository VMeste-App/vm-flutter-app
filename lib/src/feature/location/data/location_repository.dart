import 'package:vm_app/src/core/model/paged_data.dart';
import 'package:vm_app/src/feature/location/model/location.dart';
import 'package:vm_app/src/feature/location/model/location_filter.dart';

abstract interface class ILocationRepository {
  Future<PagedData<Location>> fetch(LocationFilter filter, {int page = 1});

  Future<Location> fetchById(LocationId id);

  Future<Location> create();

  // --- Favorite ---

  Future<Set<LocationId>> fetchFavorites();

  Future<void> addFavorite(LocationId id);

  Future<void> removeFavorite(LocationId id);
}

final class LocationRepository implements ILocationRepository {
  @override
  Future<PagedData<Location>> fetch(LocationFilter filter, {int page = 1}) {
    final data = [
      const Location(id: 1, name: 'Парк Маяковского', address: 'ул. 8 марта, д 45', lat: 10, lng: 10, cityId: 1),
      const Location(id: 2, name: 'Луч', address: 'ул. 8 марта, д 45', lat: 10, lng: 10, cityId: 1),
      const Location(id: 3, name: 'Факел', address: 'ул. 8 марта, д 45', lat: 10, lng: 10, cityId: 1),
      const Location(id: 3, name: 'Урфу', address: 'ул. 8 марта, д 45', lat: 10, lng: 10, cityId: 1),
    ];

    return Future.value(PagedData(data, page: 1, hasMore: false));
  }

  @override
  Future<Location> fetchById(LocationId id) {
    return Future.value(
      const Location(id: 1, name: 'Парк Маяковского', address: 'ул. 8 марта, д 45', lat: 10, lng: 10, cityId: 1),
    );
  }

  @override
  Future<Location> create() {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<Set<LocationId>> fetchFavorites() {
    // TODO: implement fetchFavorites
    throw UnimplementedError();
  }

  @override
  Future<void> addFavorite(LocationId id) {
    // TODO: implement addFavorite
    throw UnimplementedError();
  }

  @override
  Future<void> removeFavorite(LocationId id) {
    // TODO: implement removeFavorite
    throw UnimplementedError();
  }
}
