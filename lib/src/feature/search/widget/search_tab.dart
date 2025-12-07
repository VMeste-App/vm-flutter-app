import 'package:flutter/material.dart';
import 'package:vm_app/src/core/navigator/navigator.dart';
import 'package:vm_app/src/core/navigator/pages.dart';
import 'package:vm_app/src/core/theme/colors.dart';
import 'package:vm_app/src/core/widget/lazy_scroll_view.dart';
import 'package:vm_app/src/core/widget/safe_scaffold.dart';
import 'package:vm_app/src/feature/event/widget/event_card.dart';

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
      backgroundColor: AppColors.neutral3,
      appBar: AppBar(
        title: const Text('События'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list_rounded),
            onPressed: () => VmNavigator.push(context, const FilterPage()),
          ),
        ],
      ),
      body: LazyScrollView(
        onRefresh: Future.value,
        onLoadMore: Future.value,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          itemCount: 100,
          separatorBuilder: (context, index) => const SizedBox(height: 12.0),
          itemBuilder: (context, index) => InkWell(
            onTap: () => VmNavigator.push(context, VmEventPage(id: index)),
            child: const VmEventCard(),
          ),
        ),
      ),
    );
  }
}
