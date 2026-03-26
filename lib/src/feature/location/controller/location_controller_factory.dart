import 'package:vm_app/src/feature/location/controller/location/location_controller.dart';
import 'package:vm_app/src/feature/location/data/location_repository.dart';

final class LocationControllerFactory {
  final ILocationRepository _repository;

  LocationControllerFactory(this._repository);

  LocationController createLocationController(int locationId) =>
      LocationController(locationId, repository: _repository);
}
