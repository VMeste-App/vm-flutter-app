import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vm_app/src/core/ui-kit/bottom_sheet.dart';
import 'package:vm_app/src/core/ui-kit/text_field.dart';

class DateTimeField extends StatefulWidget {
  const DateTimeField({super.key, this.onChanged});

  final ValueChanged<DateTime>? onChanged;

  @override
  State<DateTimeField> createState() => _DateTimeFieldState();
}

class _DateTimeFieldState extends State<DateTimeField> {
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
      decoration: InputDecoration(
        hintText: 'Дата и время',
        focusedBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
        prefixIcon: const Icon(Icons.date_range_outlined),
      ),
      onTap: _onTap,
    );
  }

  Future<void> _onTap() => showVmBottomSheet<void>(
    context,
    (context) => _DateTimePicker(
      onChanged: (value) {
        _controller.text = DateFormat('dd MMMM HH:mm', 'ru').format(value);
        widget.onChanged?.call(value);
      },
    ),
  );
}

class _DateTimePicker extends StatelessWidget {
  const _DateTimePicker({required this.onChanged});

  final ValueChanged<DateTime> onChanged;

  @override
  Widget build(BuildContext context) {
    return VmBottomSheet(
      title: const Text('Начало события'),
      body: SizedBox(
        height: 250,
        child: CupertinoDatePicker(
          use24hFormat: true,
          minimumDate: DateTime.now(),
          maximumDate: DateTime.now().copyWith(month: DateTime.now().month + 1),
          onDateTimeChanged: onChanged,
        ),
      ),
      action: FilledButton(onPressed: () {}, child: const Text('Начало cегодня в 19:50')),
    );
  }
}
