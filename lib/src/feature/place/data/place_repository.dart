import 'package:dio/dio.dart';
import 'package:vm_app/src/core/model/typedefs.dart';
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
  final Dio _client;

  PlaceRepository({required Dio client}) : _client = client;

  @override
  Future<List<Place>> getPlaces(PlaceFilter filter, {int page = 1}) async {
    final response = await _client.get<Json>(
      '/places',
      queryParameters: {
        'page': page,
        ...filter.toJson(),
      },
    );

    if (response.data case {
      'data': final List<Json> data,
    }) {
      return data.map(_parsePlace).toList();
    }

    throw Exception('Failed to parse data');
  }

  @override
  Future<Place> getById(PlaceId id) async {
    final response = await _client.get<Json>('/places/{$id}');
    return _parsePlaceFromResponse(response);
  }

  @override
  Future<Place> create(Place$Create place) async {
    final response = await _client.post<Json>('/places', data: place.toJson());
    return _parsePlaceFromResponse(response);
  }

  Place _parsePlaceFromResponse(Response<Json> response) {
    if (response.data case final data?) {
      return _parsePlace(data);
    }

    throw Exception('Failed to parse data');
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
