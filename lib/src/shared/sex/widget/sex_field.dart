import 'package:flutter/material.dart';
import 'package:vm_app/src/shared/level/model/level.dart';
import 'package:vm_app/src/shared/sex/model/sex.dart';

class SexField extends StatefulWidget {
  const SexField({super.key, this.selected, this.onChanged});

  final SkillLevelId? selected;
  final ValueChanged<SkillLevelId>? onChanged;

  @override
  State<SexField> createState() => _SexFieldState();
}

class _SexFieldState extends State<SexField> {
  late final ValueNotifier<SkillLevelId?> _levelController;

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
        children: EventMembersType.values
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
