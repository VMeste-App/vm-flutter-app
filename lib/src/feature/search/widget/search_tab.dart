import 'package:flutter/material.dart';
import 'package:vm_app/src/core/widget/safe_scaffold.dart';

/// {@template search_tab}
/// SearchTab widget.
/// {@endtemplate}
class SearchTab extends StatelessWidget {
  /// {@macro search_tab}
  const SearchTab({
    super.key, // ignore: unused_element
  });

  @override
  Widget build(BuildContext context) {
    return SafeScaffold(
      appBar: AppBar(
        title: const Text('События'),
        // actions: [IconButton(onPressed: () => context.octopus.push(Routes.create), icon: const Icon(Icons.add))],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        itemCount: 100,
        separatorBuilder: (context, index) => const SizedBox(height: 12.0),
        itemBuilder: (context, index) => const Card(),
      ),
    );
  }
}
