import 'package:flutter/widgets.dart';
import 'package:vm_app/src/feature/favorite/widget/scope/favorite_event_scope.dart';
import 'package:vm_app/src/feature/favorite/widget/scope/favorite_place_scope.dart';
import 'package:vm_app/src/feature/favorite/widget/scope/favorite_profile_scope.dart';

class FavoriteScope extends StatelessWidget {
  const FavoriteScope({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FavoriteScope$Event(
      child: FavoriteScope$Profile(
        child: FavoriteScope$Place(
          child: child,
        ),
      ),
    );
  }
}
