import 'package:flutter/material.dart';
import 'package:vm_app/src/core/ui-kit/label.dart';
import 'package:vm_app/src/core/ui-kit/text_field.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    this.controller,
    this.onSubmitted,
    this.errorText,
  }) : _autofillHints = const [AutofillHints.password];

  const PasswordField.create({
    super.key,
    this.controller,
    this.onSubmitted,
    this.errorText,
  }) : _autofillHints = const [AutofillHints.newPassword];

  final TextEditingController? controller;
  final VoidCallback? onSubmitted;
  final String? errorText;
  final Iterable<String>? _autofillHints;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return VmLabel(
      title: const Text('Password'),
      child: VmTextField(
        obscureText: _obscureText,
        controller: widget.controller,
        textInputAction: TextInputAction.done,
        onSubmitted: (_) => widget.onSubmitted?.call(),
        autofillHints: widget._autofillHints,
        keyboardType: TextInputType.visiblePassword,
        maxLines: 1,
        enableSuggestions: false,
        decoration: InputDecoration(
          hintText: 'Password',
          suffixIcon: IconButton(
            icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
            onPressed: () => setState(() => _obscureText = !_obscureText),
          ),
          errorText: widget.errorText,
        ),
      ),
    );
  }
}
