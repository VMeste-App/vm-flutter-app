import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/src/components/bottom_sheet.dart';
import 'package:ui_kit/src/components/button.dart';
import 'package:ui_kit/src/components/text_field.dart';

class SexController<T extends Object> extends ValueNotifier<T?> {
  SexController([super.value]);
}

class SexField2<T extends Object> extends StatefulWidget {
  const SexField2({
    super.key,
    required this.controller,
    required this.items,
    required this.labelBuilder,
    this.title = 'Пол',
    this.hintText,
    this.errorText,
  });

  final SexController<T> controller;
  final List<T> items;
  final String Function(T value) labelBuilder;
  final String title;
  final String? hintText;
  final String? errorText;

  @override
  State<SexField2<T>> createState() => _SexField2State<T>();
}

class _SexField2State<T extends Object> extends State<SexField2<T>> {
  late final _textController = TextEditingController(text: _textFor(widget.controller.value));

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
      onTap: _onTap,
      decoration: InputDecoration(
        hintText: widget.hintText ?? widget.title,
        errorText: widget.errorText,
        suffixIcon: const RotatedBox(quarterTurns: 1, child: Icon(Icons.chevron_right_outlined)),
      ),
    );
  }

  Future<void> _onTap() {
    if (widget.items.isEmpty) return Future.value();

    return showVmBottomSheet<void>(
      context,
      (context) => _OptionPicker<T>(
        title: widget.title,
        items: widget.items,
        initial: widget.controller.value ?? widget.items.first,
        labelBuilder: widget.labelBuilder,
        onSelected: (value) {
          _textController.text = widget.labelBuilder(value);
          widget.controller.value = value;
        },
      ),
    );
  }

  void _syncText() {
    _textController.text = _textFor(widget.controller.value);
  }

  String _textFor(T? value) => value == null ? '' : widget.labelBuilder(value);
}

class _OptionPicker<T extends Object> extends StatefulWidget {
  const _OptionPicker({
    required this.title,
    required this.items,
    required this.initial,
    required this.labelBuilder,
    required this.onSelected,
  });

  final String title;
  final List<T> items;
  final T initial;
  final String Function(T value) labelBuilder;
  final ValueChanged<T> onSelected;

  @override
  State<_OptionPicker<T>> createState() => _OptionPickerState<T>();
}

class _OptionPickerState<T extends Object> extends State<_OptionPicker<T>> {
  late final _controller = FixedExtentScrollController(initialItem: widget.items.indexOf(widget.initial));
  late final _focused = ValueNotifier<T>(widget.initial);

  @override
  void dispose() {
    _controller.dispose();
    _focused.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VmBottomSheet(
      title: Text(widget.title),
      body: SizedBox(
        height: 200.0,
        child: CupertinoPicker(
          itemExtent: 40.0,
          scrollController: _controller,
          onSelectedItemChanged: (value) => _focused.value = widget.items[value],
          children: widget.items.map((item) => Center(child: Text(widget.labelBuilder(item)))).toList(),
        ),
      ),
      action: VmButton(
        onPressed: () {
          Navigator.pop(context);
          widget.onSelected(_focused.value);
        },
        child: ValueListenableBuilder(
          valueListenable: _focused,
          builder: (context, value, child) => Text(widget.labelBuilder(value)),
        ),
      ),
    );
  }
}
