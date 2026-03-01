import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vm_app/src/core/ui-kit/text_field.dart';

/// {@template price_filed}
/// PriceField widget.
/// {@endtemplate}
class PriceField extends StatelessWidget {
  /// {@macro price_filed}
  const PriceField({
    super.key,
    this.controller,
    this.focusNode,
    this.hintText,
    this.helperText,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText;
  final String? helperText;

  @override
  Widget build(BuildContext context) {
    return VmTextField(
      controller: controller,
      focusNode: focusNode,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        suffixText: '₽',
        hintText: hintText,
        helperMaxLines: 2,
        helperStyle: const TextStyle(color: Colors.grey),
        helperText: helperText,
      ),
      maxLines: 1,
    );
  }
}
