import 'package:flutter/material.dart';
import 'package:vm_app/src/feature/auth/widget/auth_scope.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = AuthenticationScope.controllerOf(context);

    return Center(child: FilledButton(onPressed: controller.signIn, child: const Text('Sign in')));
  }
}
