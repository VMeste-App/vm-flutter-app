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
  late final bool _ownsController;

  @override
  void initState() {
    super.initState();
    _ownsController = widget.controller == null;
    _controller = widget.controller ?? ValueNotifier(widget.selected);
  }

  @override
  void dispose() {
    if (_ownsController) {
      _controller.dispose();
    }

    super.dispose();
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
          final isSelected = selected == item.id;

          return _VmPickerListTile(
            title: Text(item.title),
            selected: isSelected,
            onTap: () {
              _controller.value = item.id;
              widget.onSelected?.call(item.id);
            },
          );
        },
      ),
    );
  }
}

class _VmPickerListTile extends StatelessWidget {
  const _VmPickerListTile({
    required this.title,
    required this.selected,
    required this.onTap,
  });

  final Widget title;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      title: title,
      selected: selected,
      trailing: selected ? Icon(Icons.check, color: theme.colorScheme.primary) : null,
      onTap: onTap,
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
