import 'package:meta/meta.dart';

@immutable
class LocationFilter {
  final String? search;
  final int? cityId;

  const LocationFilter({
    this.search,
    this.cityId,
  });
}
