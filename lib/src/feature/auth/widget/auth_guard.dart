import 'package:control/control.dart';
import 'package:flutter/widgets.dart';
import 'package:vm_app/src/feature/auth/controller/auth_controller.dart';
import 'package:vm_app/src/feature/auth/widget/auth_scope.dart';
import 'package:vm_app/src/feature/auth/widget/sign_in_screen.dart';

/// {@template auth_guard}
/// AuthGuard widget.
/// {@endtemplate}
class AuthGuard extends StatelessWidget {
  /// {@macro auth_guard}
  const AuthGuard({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return StateConsumer<AuthController, AuthState>(
      controller: AuthScope.controllerOf(context),
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state, _) {
        if (state.status.isAuthenticated) {
          return child;
        }

        return const SignInScreen();
      },
    );
  }
}
