import 'package:flutter/widgets.dart';
import 'package:vm_app/src/core/di/dependencies.dart';
import 'package:vm_app/src/core/utils/extensions/context_extension.dart';
import 'package:vm_app/src/feature/auth/controller/authentication_controller.dart';
import 'package:vm_app/src/feature/auth/model/user.dart';

class AuthenticationScope extends StatefulWidget {
  const AuthenticationScope({super.key, required this.child});

  /// The widget below this widget in the tree.
  final Widget child;

  /// Current user.
  static User? userOf(BuildContext context, {bool listen = true}) =>
      _InheritedAuthenticationScope.userOf(context, listen: listen);

  /// User ID.
  static UserID? userIdOf(BuildContext context, {bool listen = true}) => userOf(context, listen: listen)?.id;

  /// Is current user?
  static bool isMe(BuildContext context, UserID id, {bool listen = true}) => userIdOf(context, listen: listen) == id;

  /// Is authenticated?
  static bool isAuthenticated(BuildContext context, {bool listen = true}) =>
      _InheritedAuthenticationScope.isAuthenticated(context, listen: listen);

  /// Sign in.
  static void signIn(BuildContext context, String email, String password) =>
      controllerOf(context).signIn(email, password);

  /// Sign up.
  static void signUp(BuildContext context, String email, String password) =>
      _InheritedAuthenticationScope.of(context, listen: false).signUp(email, password);

  static void signOut(BuildContext context) => _InheritedAuthenticationScope.of(context, listen: false).signOut();

  /// Get the current [AuthController]
  static AuthController controllerOf(BuildContext context) => _InheritedAuthenticationScope.of(context);

  @override
  State<AuthenticationScope> createState() => _AuthenticationScopeState();
}

class _AuthenticationScopeState extends State<AuthenticationScope> {
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

class _InheritedAuthenticationScope extends InheritedWidget {
  const _InheritedAuthenticationScope({
    required this.controller,
    required this.state,
    required super.child,
  });

  final AuthController controller;
  final AuthenticationState state;

  /// Текущий пользователь.
  static User? userOf(BuildContext context, {bool listen = true}) => of(context, listen: listen).state.user;

  /// Пользователь авторизован?
  static bool isAuthenticated(BuildContext context, {bool listen = true}) => userOf(context, listen: listen) != null;

  static AuthController of(BuildContext context, {bool listen = true}) =>
      context.inhOf<_InheritedAuthenticationScope>(listen: listen).controller;

  @override
  bool updateShouldNotify(covariant _InheritedAuthenticationScope oldWidget) => !identical(oldWidget.state, state);
}
