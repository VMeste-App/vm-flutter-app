import 'package:meta/meta.dart';
import 'package:vm_app/src/core/model/typedefs.dart';

@immutable
class PlaceFilter {
  final String? search;
  final int? cityId;

  const PlaceFilter({
    this.search,
    this.cityId,
  });

  Json toJson() => {
    'search': search,
    'cityId': cityId,
  };
}
