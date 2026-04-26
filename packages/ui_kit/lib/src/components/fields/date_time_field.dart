import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ui_kit/src/components/bottom_sheet.dart';
import 'package:ui_kit/src/components/button.dart';
import 'package:ui_kit/src/components/text_field.dart';

class DateTimeField extends StatefulWidget {
  const DateTimeField({
    super.key,
    this.initial,
    this.onChanged,
    this.textBuilder,
    this.buttonTextBuilder,
    this.hintText,
    this.errorText,
  });

  final DateTime? initial;
  final ValueChanged<DateTime>? onChanged;
  final String Function(DateTime dt)? textBuilder;
  final String Function(DateTime dt)? buttonTextBuilder;
  final String? hintText;
  final String? errorText;

  @override
  State<DateTimeField> createState() => _DateTimeFieldState();
}

class _DateTimeFieldState extends State<DateTimeField> {
  final _controller = TextEditingController();
  late final _dtController = ValueNotifier<DateTime?>(widget.initial);

  @override
  void dispose() {
    _controller.dispose();
    _dtController.dispose();
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
        hintText: widget.hintText ?? 'Дата и время',
        focusedBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
        prefixIcon: const Icon(Icons.date_range_outlined),
        errorText: widget.errorText,
      ),
      onTap: _onTap,
    );
  }

  Future<void> _onTap() {
    final now = DateTime.now();

    return showVmBottomSheet<void>(
      context,
      (context) => _DateTimePicker(
        initial: _dtController.value ?? now,
        minimum: now,
        maximum: now.add(const Duration(days: 30)),
        textBuilder: widget.buttonTextBuilder,
        onSelected: (value) {
          _controller.text = widget.textBuilder?.call(value) ?? DateFormat('dd MMMM HH:mm').format(value);
          _dtController.value = value;
          widget.onChanged?.call(value);
        },
      ),
    );
  }
}

class _DateTimePicker extends StatefulWidget {
  const _DateTimePicker({this.initial, this.minimum, this.maximum, this.textBuilder, this.onSelected});

  final DateTime? initial;
  final DateTime? minimum;
  final DateTime? maximum;
  final String Function(DateTime dt)? textBuilder;
  final ValueChanged<DateTime>? onSelected;

  @override
  State<_DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<_DateTimePicker> {
  final _now = DateTime.now();
  late final _focused = ValueNotifier<DateTime>(widget.initial ?? _now);

  @override
  void dispose() {
    _focused.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VmBottomSheet(
      title: const Text('Начало события'),
      body: SizedBox(
        height: 250,
        child: CupertinoDatePicker(
          use24hFormat: true,
          initialDateTime: widget.initial ?? _now,
          minimumDate: widget.minimum,
          maximumDate: widget.maximum,
          onDateTimeChanged: (value) => _focused.value = value,
        ),
      ),
      action: VmButton(
        onPressed: () {
          Navigator.pop(context);
          widget.onSelected?.call(_focused.value);
        },
        child: ValueListenableBuilder(
          valueListenable: _focused,
          builder: (context, value, child) {
            return Text(widget.textBuilder?.call(value) ?? DateFormat('dd MMMM HH:mm').format(value));
          },
        ),
      ),
    );
  }
}
