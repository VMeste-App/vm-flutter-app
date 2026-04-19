import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vm_app/src/core/ui-kit/text_field.dart';

class HeightField extends StatelessWidget {
  const HeightField({
    super.key,
    this.initial,
    this.controller,
    this.focusNode,
  });

  final int? initial;
  final TextEditingController? controller;
  final FocusNode? focusNode;

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
      decoration: const InputDecoration(
        suffixText: 'см',
        hintText: '175',
      ),
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
