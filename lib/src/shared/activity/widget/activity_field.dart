import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:vm_app/src/shared/activity/model/activity.dart';
import 'package:vm_app/src/shared/activity/widget/activities_screen.dart';
import 'package:vm_app/src/shared/activity/widget/activity_scope.dart';

class ActivityField extends StatefulWidget {
  const ActivityField({
    super.key,
    this.onChanged,
    this.errorText,
  });

  final ValueChanged<ActivityId>? onChanged;
  final String? errorText;

  @override
  State<ActivityField> createState() => _ActivityFieldState();
}

class _ActivityFieldState extends State<ActivityField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VmTextField(
      controller: _controller,
      enableInteractiveSelection: false,
      maxLines: 1,
      readOnly: true,
      decoration: InputDecoration(
        hintText: 'Выбрать',
        errorText: widget.errorText,
        focusedBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
      ),
      onTap: _openActivities,
    );
  }

  Future<void> _openActivities() async {
    final id = int.tryParse(_controller.text);
    final activityID = await Navigator.of(
      context,
    ).push(MaterialPageRoute<ActivityId>(builder: (context) => ActivitiesScreen(selected: id)));

    if (!mounted || activityID == null) return;

    widget.onChanged?.call(activityID);
    final activity = ActivityScope.activityOf(context, activityID);
    if (activity != null) {
      _controller.text = activity.name;
    }
  }
}
