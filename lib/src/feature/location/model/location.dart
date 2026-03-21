import 'package:meta/meta.dart';

typedef CityId = int;
typedef LocationId = int;

@immutable
final class Location {
  final LocationId id;
  final CityId cityId;
  final String name;
  final String address;
  final double lat;
  final double lng;

  const Location({
    required this.id,
    required this.cityId,
    required this.name,
    required this.address,
    required this.lat,
    required this.lng,
  });
}
