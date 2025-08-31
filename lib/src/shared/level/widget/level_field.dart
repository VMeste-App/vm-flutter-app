import 'package:flutter/material.dart';
import 'package:vm_app/src/shared/level/model/level.dart';

class LevelField extends StatefulWidget {
  const LevelField({super.key, this.selected, this.onChanged});

  final LevelID? selected;
  final ValueChanged<LevelID>? onChanged;

  @override
  State<LevelField> createState() => _LevelFieldState();
}

class _LevelFieldState extends State<LevelField> {
  late final ValueNotifier<LevelID?> _levelController;

  @override
  void initState() {
    super.initState();
    _levelController = ValueNotifier(widget.selected);
  }

  @override
  void dispose() {
    _levelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _levelController,
      builder: (context, selected, _) => Column(
        mainAxisSize: MainAxisSize.min,
        children: Level.values
            .map(
              (level) => CheckboxListTile(
                title: Text(level.name),
                value: selected == level.id,
                onChanged: (value) {
                  if (value ?? false) {
                    _levelController.value = level.id;
                  }
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
