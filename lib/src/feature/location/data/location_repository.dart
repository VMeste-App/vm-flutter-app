import 'package:vm_app/src/feature/location/model/location.dart';
import 'package:vm_app/src/feature/location/model/location_filter.dart';

abstract interface class ILocationRepository {
  Future<List<Location>> fetch(LocationFilter filter);

  Future<List<Location>> fetchById(LocationId id);

  Future<Location> create();

  Future<List<Location>> fetchFavorites();

  Future<void> addFavorite(Location location);

  Future<void> removeFavorite(LocationId id);
}

final class LocationRepository implements ILocationRepository {
  @override
  Future<List<Location>> fetch(LocationFilter filter) {
    return Future.value([
      const Location(id: 1, name: 'Парк Маяковского', address: 'ул. 8 марта, д 45', lat: 10, lng: 10, cityId: 1),
      const Location(id: 2, name: 'Луч', address: 'ул. 8 марта, д 45', lat: 10, lng: 10, cityId: 1),
      const Location(id: 3, name: 'Факел', address: 'ул. 8 марта, д 45', lat: 10, lng: 10, cityId: 1),
      const Location(id: 3, name: 'Урфу', address: 'ул. 8 марта, д 45', lat: 10, lng: 10, cityId: 1),
    ]);
  }

  @override
  Future<List<Location>> fetchById(LocationId id) {
    // TODO: implement fetchById
    throw UnimplementedError();
  }

  @override
  Future<Location> create() {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<List<Location>> fetchFavorites() {
    // TODO: implement fetchFavorites
    throw UnimplementedError();
  }

  @override
  Future<void> addFavorite(Location location) {
    // TODO: implement addFavorite
    throw UnimplementedError();
  }

  @override
  Future<void> removeFavorite(LocationId id) {
    // TODO: implement removeFavorite
    throw UnimplementedError();
  }
}
