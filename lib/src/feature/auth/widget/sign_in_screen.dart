import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vm_app/src/core/navigator/navigator.dart';
import 'package:vm_app/src/core/navigator/pages.dart';
import 'package:vm_app/src/core/ui-kit/button.dart';
import 'package:vm_app/src/core/widget/safe_scaffold.dart';
import 'package:vm_app/src/feature/auth/widget/authentication_scope.dart';
import 'package:vm_app/src/feature/auth/widget/components/email_field.dart';
import 'package:vm_app/src/feature/auth/widget/components/password_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // --- Error's controllers ---
  final ValueNotifier<String?> _emailError = ValueNotifier(null);
  final ValueNotifier<String?> _passwordError = ValueNotifier(null);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailError.dispose();
    _passwordError.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeScaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: AutofillGroup(
        child: Column(
          children: [
            ValueListenableBuilder(
              valueListenable: _emailError,
              builder: (context, value, child) {
                return EmailField(
                  controller: _emailController,
                  errorText: value,
                );
              },
            ),
            const SizedBox(height: 16.0),
            ValueListenableBuilder(
              valueListenable: _passwordError,
              builder: (context, value, child) {
                return PasswordField.create(
                  controller: _passwordController,
                  errorText: value,
                  onSubmitted: () => _signIn(context),
                );
              },
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  VmButton(
                    loading: AuthenticationScope.controllerOf(context).isProcessing,
                    onPressed: () => _signIn(context),
                    child: const Text('Sign in'),
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Нет аккаунта?'),
                      TextButton(
                        onPressed: () => VmNavigator.push(context, const SignUpPage()),
                        child: const Text('Регистрация'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  void _signIn(BuildContext context) {
    final email = _emailController.text;
    final password = _passwordController.text;

    final isValid = _validate(email, password);

    if (!isValid) {
      HapticFeedback.mediumImpact();

      return;
    }

    TextInput.finishAutofillContext();
    AuthenticationScope.signIn(context, email, password);
  }

  bool _validate(String email, String password) {
    bool isValid = true;

    final email = _emailController.text;
    final password = _passwordController.text;

    if (email.isEmpty) {
      isValid = false;
      _emailError.value = 'Email не может быть пустым';
    } else {
      _emailError.value = null;
    }

    if (password.isEmpty) {
      isValid = false;
      _passwordError.value = 'Пароль не может быть пустым';
    } else {
      _passwordError.value = null;
    }

    return isValid;
  }
}
