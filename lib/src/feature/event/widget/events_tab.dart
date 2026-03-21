import 'package:flutter/material.dart';
import 'package:vm_app/src/core/navigator/navigator.dart';
import 'package:vm_app/src/core/navigator/pages.dart';
import 'package:vm_app/src/core/widget/safe_scaffold.dart';
import 'package:vm_app/src/feature/event/widget/event_card.dart';

class EventsTab extends StatefulWidget {
  const EventsTab({super.key});

  @override
  State<EventsTab> createState() => _EventsTabState();
}

class _EventsTabState extends State<EventsTab> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeScaffold(
      appBar: AppBar(
        title: const Text('События'),
        actions: [
          IconButton(
            onPressed: () => VmNavigator.push(context, const CreateEventPage()),
            icon: const Icon(Icons.add),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Активные'),
            Tab(text: 'Архив'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            itemCount: 100,
            separatorBuilder: (context, index) => const SizedBox(height: 12.0),
            itemBuilder: (context, index) => InkWell(
              onTap: () => VmNavigator.push(context, VmEventPage(id: index)),
              child: const VmEventCard(),
            ),
          ),
          ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            itemCount: 100,
            separatorBuilder: (context, index) => const SizedBox(height: 12.0),
            itemBuilder: (context, index) => InkWell(
              onTap: () => VmNavigator.push(context, VmEventPage(id: index)),
              child: const VmEventCard(),
            ),
          ),
        ],
      ),
    );
  }
}
