import 'package:vm_app/src/core/model/typedefs.dart';
import 'package:vm_app/src/core/network/vm_http_client.dart';
import 'package:vm_app/src/feature/place/model/place.dart';
import 'package:vm_app/src/feature/place/model/place_filter.dart';

abstract interface class IPlaceRepository {
  /// {@template place.list}
  /// Отсрортированный список мест с пагинацией на основе фильтра.
  /// {@endtemplate}
  Future<List<Place>> getPlaces(PlaceFilter filter, {int page = 1});

  /// {@template place.byId}
  /// Получить место по [id].
  /// {@endtemplate}
  Future<Place> getById(PlaceId id);

  /// {@template place.create}
  /// Создать место.
  /// {@endtemplate}
  Future<Place> create(Place$Create place);
}

final class PlaceRepository implements IPlaceRepository {
  final VmHttpClient _client;

  PlaceRepository({required VmHttpClient client}) : _client = client;

  @override
  Future<List<Place>> getPlaces(PlaceFilter filter, {int page = 1}) async {
    final response = await _client.get(
      '/places',
      queryParameters: {
        'page': page,
        ...filter.toJson(),
      },
    );

    if (response case {
      'data': final List<Json> data,
    }) {
      return data.map(_parsePlace).toList();
    }

    throw Exception('Failed to parse data');
  }

  @override
  Future<Place> getById(PlaceId id) async {
    final response = await _client.get('/places/{$id}');
    return _parsePlace(response);
  }

  @override
  Future<Place> create(Place$Create place) async {
    final response = await _client.post('/places', body: place.toJson());
    return _parsePlace(response);
  }

  Place _parsePlace(Json data) {
    if (data case {
      'id': final PlaceId id,
      'city_id': final CityId cityId,
      'name': final String name,
      'address': final String address,
      'lat': final double lat,
      'lng': final double lng,
    }) {
      return Place(
        id: id,
        cityId: cityId,
        name: name,
        address: address,
        lat: lat,
        lng: lng,
      );
    }

    throw Exception('Failed to parse event');
  }
}
