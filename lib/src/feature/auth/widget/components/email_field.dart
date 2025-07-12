import 'package:flutter/material.dart';
import 'package:vm_app/src/core/ui-kit/label.dart';
import 'package:vm_app/src/core/ui-kit/text_field.dart';

class EmailField extends StatelessWidget {
  const EmailField({
    super.key,
    this.controller,
    this.onSubmitted,
    this.errorText,
  });

  final TextEditingController? controller;
  final VoidCallback? onSubmitted;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return VmLabel(
      title: const Text('Email'),
      child: VmTextField(
        controller: controller,
        textInputAction: TextInputAction.next,
        onSubmitted: (_) => onSubmitted?.call(),
        autofillHints: const [AutofillHints.email],
        keyboardType: TextInputType.emailAddress,
        maxLines: 1,
        decoration: InputDecoration(
          hintText: 'Email',
          errorText: errorText,
        ),
      ),
    );
  }
}
