import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vm_app/src/core/ui-kit/bottom_sheet.dart';
import 'package:vm_app/src/core/ui-kit/button.dart';
import 'package:vm_app/src/core/ui-kit/text_field.dart';
import 'package:vm_app/src/feature/profile/model/sex.dart';

class SexController extends ValueNotifier<Sex?> {
  SexController([super.value]);
}

class SexField2 extends StatefulWidget {
  const SexField2({
    super.key,
    required this.controller,
    this.hintText,
    this.errorText,
  });

  final SexController controller;
  final String? hintText;
  final String? errorText;

  @override
  State<SexField2> createState() => _SexField2State();
}

class _SexField2State extends State<SexField2> {
  late final _textController = TextEditingController(text: widget.controller.value?.name);

  @override
  void dispose() {
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
      onTap: _onTap,
      decoration: InputDecoration(
        hintText: widget.hintText ?? 'Пол',
        errorText: widget.errorText,
        suffixIcon: const RotatedBox(
          quarterTurns: 1,
          child: Icon(Icons.chevron_right_outlined),
        ),
      ),
    );
  }

  Future<void> _onTap() {
    return showVmBottomSheet<void>(
      context,
      (context) => _SexPicker(
        initial: widget.controller.value ?? Sex.male,
        onSelected: (value) {
          _textController.text = value.name;
          widget.controller.value = value;
        },
      ),
    );
  }
}

class _SexPicker extends StatefulWidget {
  const _SexPicker({
    this.initial,
    this.onSelected,
  });

  final Sex? initial;
  final ValueChanged<Sex>? onSelected;

  @override
  State<_SexPicker> createState() => _SexPickerState();
}

class _SexPickerState extends State<_SexPicker> {
  late final _initial = widget.initial ?? Sex.male;
  late final _controller = FixedExtentScrollController(initialItem: _initial.index);
  late final _focused = ValueNotifier<Sex>(_initial);

  @override
  void dispose() {
    _focused.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VmBottomSheet(
      title: const Text('Пол'),
      body: SizedBox(
        height: 200,
        child: CupertinoPicker(
          itemExtent: 40,
          scrollController: _controller,
          onSelectedItemChanged: (value) => _focused.value = Sex.values[value],
          children: Sex.values.map((sex) => Center(child: Text(sex.name))).toList(),
        ),
      ),
      action: VmButton(
        onPressed: () {
          Navigator.pop(context);
          widget.onSelected?.call(_focused.value);
        },
        child: ValueListenableBuilder(
          valueListenable: _focused,
          builder: (context, value, child) => Text(value.name),
        ),
      ),
    );
  }
}
