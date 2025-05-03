import 'package:flutter/material.dart';
import 'package:vm_app/src/feature/auth/widget/auth_scope.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FilledButton(onPressed: () => AuthScope.signIn(context, '', ''), child: const Text('Sign in')),
    );
  }
}
