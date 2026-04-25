import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vm_app/src/core/ui-kit/text_field.dart';

class WeightField extends StatelessWidget {
  const WeightField({
    super.key,
    this.initial,
    this.controller,
    this.focusNode,
    this.errorText,
  });

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
      decoration: InputDecoration(
        suffixText: 'кг',
        hintText: '80',
        errorText: errorText,
      ),
    );
  }
}

bool validateWeight(String? value) {
  if (value == null) return false;

  if (int.tryParse(value) case final weight?) {
    return weight >= 30 && weight <= 200;
  }

  return false;
}
