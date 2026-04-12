import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:vm_app/src/core/di/dependencies.dart';
import 'package:vm_app/src/core/utils/extensions/context_extension.dart';
import 'package:vm_app/src/feature/favorite/controller/favorite_controller.dart';
import 'package:vm_app/src/feature/profile/model/profile.dart';

class FavoriteScope$Profile extends StatefulWidget {
  const FavoriteScope$Profile({
    super.key,
    required this.child,
  });

  final Widget child;

  static bool isFavorite(BuildContext context, ProfileId id, {bool listen = true}) =>
      _InheritedFavorite$Profile.isFavorite(context, id, listen: listen);

  static void add(BuildContext context, ProfileId id) => _controller(context).add(id);

  static void remove(BuildContext context, ProfileId id) => _controller(context).remove(id);

  static FavoriteController$Profile _controller(BuildContext context) =>
      Dependencies.of(context).profileFavoriteController;

  @override
  State<FavoriteScope$Profile> createState() => _FavoriteScope$ProfileState();
}

class _FavoriteScope$ProfileState extends State<FavoriteScope$Profile> {
  late final _controller = Dependencies.of(context).profileFavoriteController;
  Set<ProfileId> _favorites = {};

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
  Widget build(BuildContext context) => _InheritedFavorite$Profile(
    favorites: _favorites,
    child: widget.child,
  );
}

class _InheritedFavorite$Profile extends InheritedModel<ProfileId> {
  const _InheritedFavorite$Profile({
    required this.favorites,
    required super.child,
  });

  final Set<ProfileId> favorites;

  static _InheritedFavorite$Profile of(BuildContext context, {bool listen = true}) => context.inhOf(listen: listen);

  static bool isFavorite(BuildContext context, ProfileId id, {bool listen = true}) =>
      (listen ? context.inheritFrom<ProfileId, _InheritedFavorite$Profile>(aspect: id) : of(context, listen: false))
          .favorites
          .contains(id);

  @override
  bool updateShouldNotify(covariant _InheritedFavorite$Profile oldWidget) => !setEquals(favorites, oldWidget.favorites);

  @override
  bool updateShouldNotifyDependent(covariant _InheritedFavorite$Profile oldWidget, Set<ProfileId> aspects) {
    for (final id in aspects) {
      if (favorites.contains(id) != oldWidget.favorites.contains(id)) return true;
    }
    return false;
  }
}
