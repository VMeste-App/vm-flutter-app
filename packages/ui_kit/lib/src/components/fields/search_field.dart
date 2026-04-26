import 'package:flutter/material.dart';
import 'package:ui_kit/src/components/text_field.dart';

class SearchField extends StatefulWidget {
  const SearchField({super.key});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VmTextField(
      controller: _controller,
      maxLines: 1,
      decoration: InputDecoration(
        hintText: 'Поиск',
        focusedBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
        prefixIcon: const Icon(Icons.search),
      ),
    );
  }
}
