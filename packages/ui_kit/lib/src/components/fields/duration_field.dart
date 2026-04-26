import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/src/components/bottom_sheet.dart';
import 'package:ui_kit/src/components/button.dart';
import 'package:ui_kit/src/components/text_field.dart';

class DurationField extends StatefulWidget {
  const DurationField({super.key, this.initial, this.onChanged, this.errorText});

  final Duration? initial;
  final ValueChanged<Duration>? onChanged;
  final String? errorText;

  @override
  State<DurationField> createState() => _DurationFieldState();
}

class _DurationFieldState extends State<DurationField> {
  final _controller = TextEditingController();
  late final _durationController = ValueNotifier<Duration>(widget.initial ?? Duration.zero);

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
        errorText: widget.errorText,
      ),
      onTap: _onTap,
    );
  }

  Future<void> _onTap() => showVmBottomSheet<void>(
    context,
    (context) => _DurationPicker(
      initial: _durationController.value,
      onSelected: (value) {
        _durationController.value = value;
        _controller.text = value.toText;
        widget.onChanged?.call(value);
      },
    ),
  );
}

class _DurationPicker extends StatefulWidget {
  const _DurationPicker({required this.initial, required this.onSelected});

  final Duration initial;
  final ValueChanged<Duration> onSelected;

  @override
  State<_DurationPicker> createState() => _DurationPickerState();
}

class _DurationPickerState extends State<_DurationPicker> {
  late final _focused = ValueNotifier<Duration>(widget.initial);

  @override
  void dispose() {
    _focused.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VmBottomSheet(
      title: const Text('Длительность'),
      body: SizedBox(
        height: 250,
        child: CupertinoTimerPicker(
          initialTimerDuration: _focused.value,
          mode: CupertinoTimerPickerMode.hm,
          onTimerDurationChanged: (value) => _focused.value = value,
        ),
      ),
      action: ValueListenableBuilder(
        valueListenable: _focused,
        builder: (context, focused, child) {
          return VmButton(
            enabled: focused != widget.initial && focused.inMinutes > 0,
            onPressed: () {
              Navigator.pop(context);
              widget.onSelected.call(_focused.value);
            },
            child: Text(focused.toText),
          );
        },
      ),
    );
  }
}

extension DurationUi on Duration {
  String get toText {
    final minutes = inMinutes.remainder(60);

    if (inHours > 0 && minutes > 0) return '$inHours часа $minutes минут';
    if (inHours > 0) return '$inHours часов';
    return '$minutes минут';
  }
}
