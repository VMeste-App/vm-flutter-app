import 'package:meta/meta.dart';
import 'package:vm_app/src/core/model/typedefs.dart';

typedef CityId = int;
typedef PlaceId = int;

@immutable
final class Place {
  final PlaceId id;
  final CityId cityId;
  final String name;
  final String address;
  final double lat;
  final double lng;

  const Place({
    required this.id,
    required this.cityId,
    required this.name,
    required this.address,
    required this.lat,
    required this.lng,
  });
}

@immutable
final class Place$Create {
  final CityId cityId;
  final String name;
  final String address;
  final double lat;
  final double lng;

  const Place$Create({
    required this.cityId,
    required this.name,
    required this.address,
    required this.lat,
    required this.lng,
  });

  Json toJson() => {
    'city_id': cityId,
    'name': name,
    'address': address,
    'lat': lat,
    'lng': lng,
  };
}
