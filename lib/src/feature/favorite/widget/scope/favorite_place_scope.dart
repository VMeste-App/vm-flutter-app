import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:vm_app/src/core/di/dependencies.dart';
import 'package:vm_app/src/core/utils/extensions/context_extension.dart';
import 'package:vm_app/src/feature/favorite/controller/favorite_controller.dart';
import 'package:vm_app/src/feature/place/model/place.dart';

class FavoriteScope$Place extends StatefulWidget {
  const FavoriteScope$Place({
    super.key,
    required this.child,
  });

  final Widget child;

  static bool isFavorite(BuildContext context, PlaceId id, {bool listen = true}) =>
      _InheritedFavorite$Place.isFavorite(context, id, listen: listen);

  static void add(BuildContext context, PlaceId id) => _controller(context).add(id);

  static void remove(BuildContext context, PlaceId id) => _controller(context).remove(id);

  static FavoriteController$Event _controller(BuildContext context) => Dependencies.of(context).eventFavoriteController;

  @override
  State<FavoriteScope$Place> createState() => _FavoriteScope$PlaceState();
}

class _FavoriteScope$PlaceState extends State<FavoriteScope$Place> {
  late final _controller = Dependencies.of(context).eventFavoriteController;
  Set<PlaceId> _favorites = {};

  @override
  void initState() {
    super.initState();
    _controller
      ..init()
      ..addListener(_onFavoriteChanged);
    _onFavoriteChanged();
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_onFavoriteChanged)
      ..dispose();
    super.dispose();
  }

  void _onFavoriteChanged() {
    if (!mounted) return;
    if (identical(_favorites, _controller.state.ids)) return;
    _favorites = _controller.state.ids;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => _InheritedFavorite$Place(
    favorites: _favorites,
    child: widget.child,
  );
}

class _InheritedFavorite$Place extends InheritedModel<PlaceId> {
  const _InheritedFavorite$Place({
    required this.favorites,
    required super.child,
  });

  final Set<PlaceId> favorites;

  static _InheritedFavorite$Place of(BuildContext context, {bool listen = true}) => context.inhOf(listen: listen);

  static bool isFavorite(BuildContext context, PlaceId id, {bool listen = true}) =>
      (listen ? context.inheritFrom<PlaceId, _InheritedFavorite$Place>(aspect: id) : of(context, listen: false))
          .favorites
          .contains(id);

  @override
  bool updateShouldNotify(covariant _InheritedFavorite$Place oldWidget) => !setEquals(favorites, oldWidget.favorites);

  @override
  bool updateShouldNotifyDependent(covariant _InheritedFavorite$Place oldWidget, Set<PlaceId> aspects) {
    for (final id in aspects) {
      if (favorites.contains(id) != oldWidget.favorites.contains(id)) return true;
    }
    return false;
  }
}
