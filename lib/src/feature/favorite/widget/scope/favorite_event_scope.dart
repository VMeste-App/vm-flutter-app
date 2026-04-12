import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:vm_app/src/core/di/dependencies.dart';
import 'package:vm_app/src/core/utils/extensions/context_extension.dart';
import 'package:vm_app/src/feature/event/model/event.dart';
import 'package:vm_app/src/feature/favorite/controller/favorite_controller.dart';

class FavoriteScope$Event extends StatefulWidget {
  const FavoriteScope$Event({
    super.key,
    required this.child,
  });

  final Widget child;

  static bool isFavorite(BuildContext context, VmEventId id, {bool listen = true}) =>
      _InheritedFavorite$Event.isFavorite(context, id, listen: listen);

  static void add(BuildContext context, VmEventId id) => _controller(context).add(id);

  static void remove(BuildContext context, VmEventId id) => _controller(context).remove(id);

  static FavoriteController$Event _controller(BuildContext context) => Dependencies.of(context).eventFavoriteController;

  @override
  State<FavoriteScope$Event> createState() => _FavoriteScope$EventState();
}

class _FavoriteScope$EventState extends State<FavoriteScope$Event> {
  late final _controller = Dependencies.of(context).eventFavoriteController;
  Set<VmEventId> _favorites = {};

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
  Widget build(BuildContext context) => _InheritedFavorite$Event(
    favorites: _favorites,
    child: widget.child,
  );
}

class _InheritedFavorite$Event extends InheritedModel<VmEventId> {
  const _InheritedFavorite$Event({
    required this.favorites,
    required super.child,
  });

  final Set<VmEventId> favorites;

  static _InheritedFavorite$Event of(BuildContext context, {bool listen = true}) => context.inhOf(listen: listen);

  static bool isFavorite(BuildContext context, VmEventId id, {bool listen = true}) =>
      (listen ? context.inheritFrom<VmEventId, _InheritedFavorite$Event>(aspect: id) : of(context, listen: false))
          .favorites
          .contains(id);

  @override
  bool updateShouldNotify(covariant _InheritedFavorite$Event oldWidget) => !setEquals(favorites, oldWidget.favorites);

  @override
  bool updateShouldNotifyDependent(covariant _InheritedFavorite$Event oldWidget, Set<VmEventId> aspects) {
    for (final id in aspects) {
      if (favorites.contains(id) != oldWidget.favorites.contains(id)) return true;
    }
    return false;
  }
}
