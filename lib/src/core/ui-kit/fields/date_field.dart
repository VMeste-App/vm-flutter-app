import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vm_app/src/core/ui-kit/bottom_sheet.dart';
import 'package:vm_app/src/core/ui-kit/button.dart';
import 'package:vm_app/src/core/ui-kit/text_field.dart';

class DateController extends ValueNotifier<DateTime?> {
  DateController([super.value]);
}

class DateField extends StatefulWidget {
  const DateField({
    super.key,
    required this.controller,
    this.textBuilder,
    this.buttonTextBuilder,
    this.hintText,
    this.helperText,
    this.errorText,
  });

  final DateController controller;
  final String Function(DateTime dt)? textBuilder;
  final String Function(DateTime dt)? buttonTextBuilder;
  final String? hintText;
  final String? helperText;
  final String? errorText;

  @override
  State<DateField> createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {
  final _textController = TextEditingController();
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_syncText);
    _syncText();
  }

  @override
  void dispose() {
    widget.controller.removeListener(_syncText);
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VmTextField(
      controller: _textController,
      readOnly: true,
      enableInteractiveSelection: false,
      maxLines: 1,
      decoration: InputDecoration(
        hintText: widget.hintText,
        helperText: widget.helperText,
        errorText: widget.errorText,
        suffixIcon: const Icon(Icons.date_range_outlined),
      ),
      onTap: _onTap,
    );
  }

  Future<void> _onTap() {
    final now = DateTime.now();

    return showVmBottomSheet<void>(
      context,
      (context) => _DateTimePicker(
        initial: widget.controller.value ?? now,
        minimum: DateTime(1900),
        maximum: now,
        textBuilder: widget.buttonTextBuilder,
        onSelected: (value) {
          _textController.text = widget.textBuilder?.call(value) ?? DateFormat.yMMMMd().format(value);
          widget.controller.value = value;
        },
      ),
    );
  }

  void _syncText() {
    _textController.text = widget.controller.value == null ? '' : DateFormat.yMMMMd().format(widget.controller.value!);
  }
}

class _DateTimePicker extends StatefulWidget {
  const _DateTimePicker({
    this.initial,
    this.minimum,
    this.maximum,
    this.textBuilder,
    this.onSelected,
  });

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
          mode: CupertinoDatePickerMode.date,
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
            return Text(widget.textBuilder?.call(value) ?? DateFormat.yMMMMd().format(value));
          },
        ),
      ),
    );
  }
}
