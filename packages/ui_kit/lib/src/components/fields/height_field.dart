import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_kit/src/components/text_field.dart';

class HeightField extends StatelessWidget {
  const HeightField({super.key, this.initial, this.controller, this.focusNode, this.errorText});

  final int? initial;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return VmTextField(
      controller: controller,
      focusNode: focusNode,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
      maxLines: 1,
      maxLength: 3,
      autocorrect: false,
      enableSuggestions: false,
      showCounter: false,
      decoration: const InputDecoration(suffixText: 'см', hintText: '175').copyWith(errorText: errorText),
    );
  }
}

bool validateHeight(String? value) {
  if (value == null) return false;

  if (int.tryParse(value) case final height?) {
    return height >= 120 && height <= 240;
  }

  return false;
}
