import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});
  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  void initState() {
    super.initState();
    // Initial state initialization
  }

  @override
  void dispose() {
    // Permanent removal of a tree stent
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VmScaffold(
      appBar: AppBar(title: const Text('Фильтры')),
      body: const SizedBox(),
      persistentFooterButtons: [
        VmButton(
          onPressed: () {},
          child: const Text('Показать'),
        ),
      ],
    );
  }
}
