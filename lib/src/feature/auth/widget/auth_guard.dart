import 'package:control/control.dart';
import 'package:flutter/material.dart';
import 'package:vm_app/src/core/navigator/navigator.dart';
import 'package:vm_app/src/core/navigator/pages.dart';
import 'package:vm_app/src/feature/auth/controller/authentication_controller.dart';
import 'package:vm_app/src/feature/auth/widget/authentication_scope.dart';

class AuthGuard extends StatefulWidget {
  const AuthGuard({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<AuthGuard> createState() => _AuthGuardState();
}

class _AuthGuardState extends State<AuthGuard> {
  List<Page<Object?>> get _pages => [const SignInPage()];

  @override
  Widget build(BuildContext context) {
    return StateConsumer<AuthController, AuthenticationState>(
      controller: AuthenticationScope.controllerOf(context),
      buildWhen: (previous, current) => previous.isAuthenticated != current.isAuthenticated,
      builder: (context, state, _) {
        if (state.isAuthenticated) return widget.child;

        return VmNavigator(pages: _pages);
      },
    );
  }
}
