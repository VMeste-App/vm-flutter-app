import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vm_app/src/core/ui-kit/bottom_sheet.dart';
import 'package:vm_app/src/core/ui-kit/text_field.dart';

class DurationField extends StatefulWidget {
  const DurationField({super.key, this.onChanged});

  final ValueChanged<Duration>? onChanged;

  @override
  State<DurationField> createState() => _DurationFieldState();
}

class _DurationFieldState extends State<DurationField> {
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
      readOnly: true,
      enableInteractiveSelection: false,
      maxLines: 1,
      decoration: InputDecoration(
        hintText: 'Длительность',
        focusedBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
        prefixIcon: const Icon(Icons.watch_later_outlined),
      ),
      onTap: _onTap,
    );
  }

  Future<void> _onTap() => showVmBottomSheet<void>(
    context,
    (context) => _DurationPicker(
      onChanged: (value) {
        _controller.text = _formatDuration(value);
        widget.onChanged?.call(value);
      },
    ),
  );

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);

    if (hours > 0 && minutes > 0) {
      return '$hoursч $minutesм';
    }

    if (hours > 0) {
      return '$hoursч';
    }

    return '$minutesм';
  }
}

class _DurationPicker extends StatelessWidget {
  const _DurationPicker({required this.onChanged});

  final ValueChanged<Duration> onChanged;

  @override
  Widget build(BuildContext context) {
    return VmBottomSheet(
      title: const Text('Длительность'),
      body: SizedBox(
        height: 250,
        child: CupertinoTimerPicker(mode: CupertinoTimerPickerMode.hm, onTimerDurationChanged: onChanged),
      ),
      action: FilledButton(onPressed: () {}, child: const Text('Начало cегодня в 19:50')),
    );
  }
}
