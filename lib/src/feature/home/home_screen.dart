import 'package:flutter/material.dart';
import 'package:vm_app/src/feature/auth/widget/auth_scope.dart';

/// {@template home_screen}
/// HomeScreen widget.
/// {@endtemplate}
class HomeScreen extends StatelessWidget {
  /// {@macro home_screen}
  const HomeScreen({
    super.key, // ignore: unused_element
  });

  @override
  Widget build(BuildContext context) {
    final controller = AuthenticationScope.controllerOf(context);

    return Center(child: FilledButton(onPressed: controller.signOut, child: const Text('Sign out')));
  }
}
