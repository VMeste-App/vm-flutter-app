import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:vm_app/src/core/utils/extensions/context_extension.dart';
import 'package:vm_app/src/feature/location/controller/favorite/favorite_location_controller.dart';
import 'package:vm_app/src/feature/location/data/location_repository.dart';
import 'package:vm_app/src/feature/location/model/location.dart';

class FavoriteLocationScope extends StatefulWidget {
  const FavoriteLocationScope({
    super.key,
    required this.child,
  });

  final Widget child;

  static Set<LocationId> getFavorites(BuildContext context, {bool listen = true}) =>
      _InheritedFavorite.getFavorites(context, listen: listen);

  static bool isFavorite(BuildContext context, LocationId id, {bool listen = true}) =>
      _InheritedFavorite.isFavorite(context, id, listen: listen);

  @override
  State<FavoriteLocationScope> createState() => _FavoriteLocationScopeState();
}

class _FavoriteLocationScopeState extends State<FavoriteLocationScope> {
  late final _repository = LocationRepository();
  late final _favoriteLocationController = FavoriteLocationController(repository: _repository);

  @override
  void dispose() {
    _favoriteLocationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedFavorite(
      favorites: const {},
      child: widget.child,
    );
  }
}

class _InheritedFavorite extends InheritedModel<LocationId> {
  const _InheritedFavorite({
    required this.favorites,
    required super.child,
  });

  final Set<LocationId> favorites;

  static Set<LocationId> getFavorites(BuildContext context, {bool listen = true}) =>
      context.inhOf<_InheritedFavorite>(listen: listen).favorites;

  static bool isFavorite(BuildContext context, LocationId id, {bool listen = true}) =>
      (listen
              ? context.inheritFrom<LocationId, _InheritedFavorite>(aspect: id)
              : context.inhOf<_InheritedFavorite>(listen: false))
          .favorites
          .contains(id);

  @override
  bool updateShouldNotify(covariant _InheritedFavorite oldWidget) => !setEquals(favorites, oldWidget.favorites);

  @override
  bool updateShouldNotifyDependent(covariant _InheritedFavorite oldWidget, Set<LocationId> aspects) {
    for (final id in aspects) {
      if (favorites.contains(id) != oldWidget.favorites.contains(id)) return true;
    }
    return false;
  }
}
