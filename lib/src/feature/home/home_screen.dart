import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:vm_app/src/core/widget/lazy_indexed_stack.dart';
import 'package:vm_app/src/feature/event/widget/events_tab.dart';
import 'package:vm_app/src/feature/profile/widget/profile_tab.dart';
import 'package:vm_app/src/feature/search/widget/search_tab.dart';

/// {@template home_screen}
/// HomeScreen widget.
/// {@endtemplate}
class HomeScreen extends StatefulWidget {
  /// {@macro home_screen}
  const HomeScreen({
    super.key, // ignore: unused_element
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final ValueNotifier<int> _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = ValueNotifier(0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final controller = AuthScope.controllerOf(context);

    // return Center(child: FilledButton(onPressed: controller.signOut, child: const Text('Sign out')));

    return ValueListenableBuilder<int>(
      valueListenable: _tabController,
      builder: (context, value, _) {
        return FScaffold(
          contentPad: false,
          content: LazyIndexedStack(index: value, children: const [SearchTab(), EventsTab(), ProfileTab()]),
          footer: FBottomNavigationBar(
            index: value,
            onChange: (value) => _tabController.value = value,
            children: [
              FBottomNavigationBarItem(icon: FIcon(FAssets.icons.search), label: const Text('Поиск')),
              FBottomNavigationBarItem(icon: FIcon(FAssets.icons.activity), label: const Text('События')),
              FBottomNavigationBarItem(icon: FIcon(FAssets.icons.user), label: const Text('Профиль')),
            ],
          ),
        );
      },
    );
  }
}
