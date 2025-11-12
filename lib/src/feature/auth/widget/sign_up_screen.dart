import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vm_app/src/core/constants/regexp.dart';
import 'package:vm_app/src/core/ui-kit/button.dart';
import 'package:vm_app/src/core/widget/safe_scaffold.dart';
import 'package:vm_app/src/feature/auth/widget/authentication_scope.dart';
import 'package:vm_app/src/feature/auth/widget/components/email_field.dart';
import 'package:vm_app/src/feature/auth/widget/components/password_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
      appBar: AppBar(title: const Text('Sign Up')),
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
                return PasswordField(
                  controller: _passwordController,
                  errorText: value,
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
                    onPressed: () => _signUp(context),
                    child: const Text('Sign up'),
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Уже есть аккаунт?'),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Вход'),
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

  void _signUp(BuildContext context) {
    final email = _emailController.text;
    final password = _passwordController.text;

    final isValid = _validate(email, password);

    if (!isValid) {
      HapticFeedback.mediumImpact();

      return;
    }

    TextInput.finishAutofillContext();
    AuthenticationScope.signUp(context, email, password);
  }

  bool _validate(String email, String password) {
    bool isValid = true;

    final email = _emailController.text;
    final password = _passwordController.text;

    if (!VmRegExp.email.hasMatch(email)) {
      isValid = false;
      _emailError.value = 'Некорректный email';
    } else {
      _emailError.value = null;
    }

    if (password.length < 8) {
      isValid = false;
      _passwordError.value =
          'Пароль должен содержать строчные, заглавные буквы, цифру и спецсимвол, и быть не короче 8 символов';
    } else {
      _passwordError.value = null;
    }

    return isValid;
  }
}
