import 'package:flutter/material.dart';
import 'package:vm_app/src/core/widget/safe_scaffold.dart';

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
    return SafeScaffold(
      appBar: AppBar(title: const Text('Фильтры')),
      body: const SizedBox(),
      persistentFooterButtons: [
        FilledButton(
          onPressed: () {},
          child: const Text('Показать'),
        ),
      ],
    );
  }
}
