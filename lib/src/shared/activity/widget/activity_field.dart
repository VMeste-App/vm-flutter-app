import 'package:flutter/material.dart';
import 'package:vm_app/src/core/ui-kit/text_field.dart';
import 'package:vm_app/src/shared/activity/model/activity.dart';
import 'package:vm_app/src/shared/activity/widget/activities_screen.dart';
import 'package:vm_app/src/shared/activity/widget/activity_scope.dart';

class ActivityField extends StatefulWidget {
  const ActivityField({super.key, this.onChanged, this.errorText});

  final ValueChanged<ActivityID>? onChanged;
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
      // label: Text('Активность', style: context.theme.tileGroupStyle.enabledStyle.labelTextStyle),
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
    ).push(MaterialPageRoute<ActivityID>(builder: (context) => ActivitiesScreen(selected: id)));

    if (activityID == null) return;

    widget.onChanged?.call(activityID);
    final activity = ActivityScope.activityOf(context, activityID);
    if (activity != null) {
      _controller.text = activity.name;
    }
  }
}
