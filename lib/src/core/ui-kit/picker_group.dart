import 'package:flutter/material.dart';

class VmPickerGroup extends StatefulWidget {
  const VmPickerGroup({
    super.key,
    required this.controller,
    required this.items,
  });

  final ValueNotifier<Object?> controller;
  final List<PickerItem> items;

  @override
  State<VmPickerGroup> createState() => _VmPickerGroupState();
}

class _VmPickerGroupState extends State<VmPickerGroup> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Object?>(
      valueListenable: widget.controller,
      builder: (context, selected, _) => ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          final item = widget.items[index];

          return CheckboxListTile(
            title: Text(item.title),
            value: selected == item.id,
            onChanged: (value) {
              if (value ?? false) {
                widget.controller.value = item.id;
              }
            },
          );
        },
      ),
    );
  }
}

@immutable
final class PickerItem {
  final Object id;
  final String title;

  const PickerItem({
    required this.id,
    required this.title,
  });
}
