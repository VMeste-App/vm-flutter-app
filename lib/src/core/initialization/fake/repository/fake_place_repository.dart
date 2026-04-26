import 'package:vm_app/src/core/initialization/fake/data/fake_data.dart';
import 'package:vm_app/src/feature/place/data/place_repository.dart';
import 'package:vm_app/src/feature/place/model/place.dart';
import 'package:vm_app/src/feature/place/model/place_filter.dart';

final class FakePlaceRepository implements IPlaceRepository {
  final List<Place> _places = [...FakeData.places];

  @override
  Future<List<Place>> getPlaces(PlaceFilter filter, {int page = 1}) async {
    return [..._places];
  }

  @override
  Future<Place> getById(PlaceId id) async {
    return _places.firstWhere((place) => place.id == id);
  }

  @override
  Future<Place> create(Place$Create place) async {
    final created = Place(
      id: _nextId,
      cityId: place.cityId,
      name: place.name,
      address: place.address,
      lat: place.lat,
      lng: place.lng,
    );
    _places.add(created);
    return created;
  }

  int get _nextId => _places.isEmpty ? 1 : _places.map((place) => place.id).reduce((a, b) => a > b ? a : b) + 1;
}
