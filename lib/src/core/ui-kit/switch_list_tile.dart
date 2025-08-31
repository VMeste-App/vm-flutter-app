import 'package:flutter/material.dart';

class VmSwitchListTile extends StatelessWidget {
  const VmSwitchListTile({
    super.key,
    required this.value,
    this.title,
    this.onChanged,
    this.controller,
  });

  const VmSwitchListTile.controlled(
    this.controller, {
    super.key,
    this.title,
  }) : value = false,
       onChanged = null;

  final bool value;
  final Widget? title;
  final ValueSetter<bool>? onChanged;
  final ValueNotifier<bool>? controller;

  @override
  Widget build(BuildContext context) {
    if (controller != null) {
      return ValueListenableBuilder(
        valueListenable: controller!,
        builder: (context, value, _) =>
            SwitchListTile(value: value, title: title, onChanged: (value) => controller?.value = value),
      );
    }

    return SwitchListTile(value: value, title: title, onChanged: onChanged);
  }
}
