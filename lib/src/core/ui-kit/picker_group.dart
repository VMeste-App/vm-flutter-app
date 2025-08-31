import 'package:flutter/material.dart';

class VmPickerGroup extends StatefulWidget {
  const VmPickerGroup({
    super.key,
    required this.items,
    this.selected,
    this.onSelected,
    this.controller,
  });

  const VmPickerGroup.controlled(
    this.controller, {
    super.key,
    this.selected,
    required this.items,
    this.onSelected,
  });

  final List<PickerItem> items;
  final Object? selected;
  final ValueSetter<Object>? onSelected;
  final ValueNotifier<Object?>? controller;

  @override
  State<VmPickerGroup> createState() => _VmPickerGroupState();
}

class _VmPickerGroupState extends State<VmPickerGroup> {
  late final ValueNotifier<Object?> _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? ValueNotifier(widget.selected);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Object?>(
      valueListenable: _controller,
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
                _controller.value = item.id;
                widget.onSelected?.call(item.id);
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
