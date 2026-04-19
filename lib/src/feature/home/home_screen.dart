import 'package:flutter/material.dart';
import 'package:vm_app/src/core/ui-kit/scaffold.dart';
import 'package:vm_app/src/core/widget/lazy_indexed_stack.dart';
import 'package:vm_app/src/feature/event/widget/events_tab.dart';
import 'package:vm_app/src/feature/favorite/widget/favorite_tab.dart';
import 'package:vm_app/src/feature/profile/widget/profile_tab.dart';
import 'package:vm_app/src/feature/search/widget/serach_tab.dart';

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
    return ValueListenableBuilder<int>(
      valueListenable: _tabController,
      builder: (context, value, _) {
        return VmScaffold(
          body: LazyIndexedStack(
            index: value,
            children: const [
              SearchTab(),
              FavoriteTab(),
              EventsTab(),
              ProfileTab(),
            ],
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: value,
            onDestinationSelected: (index) => _tabController.value = index,
            destinations: const [
              NavigationDestination(icon: Icon(Icons.search), label: 'Поиск'),
              NavigationDestination(icon: Icon(Icons.favorite_border_outlined), label: 'Избранное'),
              NavigationDestination(icon: Icon(Icons.calendar_today_outlined), label: 'События'),
              NavigationDestination(icon: Icon(Icons.person_2_outlined), label: 'Профиль'),
            ],
          ),
        );
      },
    );
  }
}
