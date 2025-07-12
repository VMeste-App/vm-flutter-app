import 'package:flutter/widgets.dart';
import 'package:vm_app/src/core/di/dependencies.dart';
import 'package:vm_app/src/core/utils/extensions/context_extension.dart';
import 'package:vm_app/src/feature/auth/controller/auth_controller.dart';

class AuthScope extends StatefulWidget {
  const AuthScope({super.key, required this.child});

  /// The widget below this widget in the tree.
  final Widget child;

  /// Get the current [AuthController]
  static AuthController controllerOf(BuildContext context) => _InheritedAuthenticationScope.of(context);

  static void signIn(BuildContext context, String email, String password) =>
      _InheritedAuthenticationScope.of(context, listen: false).signIn(email, password);

  static void signUp(BuildContext context, String email, String password) =>
      _InheritedAuthenticationScope.of(context, listen: false).signUp(email, password);

  static void signOut(BuildContext context) => _InheritedAuthenticationScope.of(context, listen: false).signOut();

  @override
  State<AuthScope> createState() => _AuthScopeState();
}

/// State for widget AuthenticationScope.
class _AuthScopeState extends State<AuthScope> {
  late final AuthController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Dependencies.of(context).authController;
    _controller.addListener(_listener);
  }

  void _listener() {
    if (!mounted) return;
    setState(() {});
  }

  @override
  void dispose() {
    _controller.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _InheritedAuthenticationScope(
    controller: _controller,
    state: _controller.state,
    child: widget.child,
  );
}

/// Inherited widget for quick access in the element tree.
class _InheritedAuthenticationScope extends InheritedWidget {
  const _InheritedAuthenticationScope({
    required this.controller,
    required this.state,
    required super.child,
  });

  final AuthController controller;
  final AuthState state;

  static AuthController of(BuildContext context, {bool listen = true}) =>
      context.inhOf<_InheritedAuthenticationScope>(listen: listen).controller;

  @override
  bool updateShouldNotify(covariant _InheritedAuthenticationScope oldWidget) => !identical(oldWidget.state, state);
}
