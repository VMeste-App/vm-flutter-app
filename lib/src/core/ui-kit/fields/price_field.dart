import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vm_app/src/core/ui-kit/text_field.dart';

/// {@template price_filed}
/// PriceField widget.
/// {@endtemplate}
class PriceField extends StatelessWidget {
  /// {@macro price_filed}
  const PriceField({super.key, this.controller, this.focusNode, this.hintText});

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return VmTextField(
      controller: controller,
      focusNode: focusNode,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
      decoration: InputDecoration(suffixText: '₽', hintText: hintText),
      maxLines: 1,
    );
  }
}
