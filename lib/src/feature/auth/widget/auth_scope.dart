import 'package:flutter/widgets.dart';
import 'package:vm_app/src/core/di/dependencies.dart';
import 'package:vm_app/src/feature/auth/controller/auth_controller.dart';

class AuthScope extends StatefulWidget {
  const AuthScope({super.key, required this.child});

  /// The widget below this widget in the tree.
  final Widget child;

  /// Get the current [AuthController]
  static AuthController controllerOf(BuildContext context) => _InheritedAuthenticationScope.of(context, listen: false);

  static void signIn(BuildContext context, String login, String password) =>
      _InheritedAuthenticationScope.of(context, listen: false).signIn(login, password);

  static void signOut(BuildContext context) => _InheritedAuthenticationScope.of(context, listen: false).signOut();

  @override
  State<AuthScope> createState() => _AuthScopeState();
}

/// State for widget AuthenticationScope.
class _AuthScopeState extends State<AuthScope> {
  late final AuthController controller;

  @override
  void initState() {
    super.initState();
    controller = Dependencies.of(context).authController;
    controller.addListener(_listener);
  }

  void _listener() {
    if (!mounted) return;
    setState(() {});
  }

  @override
  void dispose() {
    controller.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      _InheritedAuthenticationScope(controller: controller, state: controller.state, child: widget.child);
}

/// Inherited widget for quick access in the element tree.
class _InheritedAuthenticationScope extends InheritedWidget {
  const _InheritedAuthenticationScope({required this.controller, required this.state, required super.child});

  final AuthController controller;
  final AuthState state;

  static AuthController? maybeOf(BuildContext context, {bool listen = true}) =>
      (listen
              ? context.dependOnInheritedWidgetOfExactType<_InheritedAuthenticationScope>()
              : context.getInheritedWidgetOfExactType<_InheritedAuthenticationScope>())
          ?.controller;

  static Never _notFoundInheritedWidgetOfExactType() =>
      throw ArgumentError(
        'Out of scope, not found inherited widget '
            'a _InheritedAuthenticationScope of the exact type',
        'out_of_scope',
      );

  static AuthController of(BuildContext context, {bool listen = true}) =>
      maybeOf(context, listen: listen) ?? _notFoundInheritedWidgetOfExactType();

  @override
  bool updateShouldNotify(covariant _InheritedAuthenticationScope oldWidget) => !identical(oldWidget.state, state);
}
