import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

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
    return FScaffold(
      contentPad: false,
      header: FHeader.nested(
        title: const Text('Поиск'),
        suffixActions: [FButton.icon(child: FIcon(FAssets.icons.slidersHorizontal), onPress: () {})],
      ),
      content: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        itemCount: 100,
        separatorBuilder: (context, index) => const SizedBox(height: 12.0),
        itemBuilder: (context, index) => FCard(title: const Text('title')),
      ),
    );
  }
}
