import 'package:flutter/material.dart';
import 'package:vm_app/src/core/ui-kit/scaffold.dart';

class FavoriteTab extends StatefulWidget {
  const FavoriteTab({super.key});

  @override
  State<FavoriteTab> createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return VmScaffold(
      appBar: AppBar(
        title: const Text('Избранное'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'События'),
            Tab(text: 'Профили'),
            Tab(text: 'Места'),
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
            itemBuilder: (context, index) => Container(),
          ),
          ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            itemCount: 100,
            separatorBuilder: (context, index) => const SizedBox(height: 12.0),
            itemBuilder: (context, index) => Container(),
          ),
          ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            itemCount: 100,
            separatorBuilder: (context, index) => const SizedBox(height: 12.0),
            itemBuilder: (context, index) => Container(),
          ),
        ],
      ),
    );
  }
}
