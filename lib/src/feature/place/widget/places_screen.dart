import 'package:control/control.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:vm_app/src/core/di/dependencies.dart';
import 'package:vm_app/src/core/navigator/navigator.dart';
import 'package:vm_app/src/core/navigator/pages.dart';
import 'package:vm_app/src/feature/place/controller/list/place_list_controller.dart';
import 'package:vm_app/src/feature/place/model/place_filter.dart';
import 'package:vm_app/src/shared/activity/model/activity.dart';

class PlacesScreen extends StatefulWidget {
  const PlacesScreen({
    super.key,
    this.selected,
  });

  final ActivityId? selected;

  @override
  State<PlacesScreen> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends State<PlacesScreen> {
  late final ValueNotifier<ActivityId?> _controller = ValueNotifier(widget.selected);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ControllerScope<PlaceListController>(
      () => PlaceListController(repository: Dependencies.of(context).placeRepository)..fetch(const PlaceFilter()),
      child: StateConsumer<PlaceListController, SearchLocationState>(
        builder: (context, state, child) {
          return VmScaffold(
            appBar: AppBar(title: const Text('Локация')),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: VmButton(
              stretched: false,
              onPressed: () => VmNavigator.push(context, const VmPlacesMapPage()),
              icon: const Icon(Icons.map_outlined),
              child: const Text('Карта'),
            ),
            body: CustomScrollView(
              slivers: [
                const SliverPadding(
                  padding: EdgeInsets.all(16.0),
                  sliver: SliverToBoxAdapter(child: SearchField()),
                ),
                SliverList.builder(
                  itemCount: state.locations.length,
                  itemBuilder: (context, index) {
                    final location = state.locations[index];
                    final colors = VmThemeColors.of(context);

                    return ListTile(
                      key: ValueKey(location.id),
                      focusColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      selectedTileColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      enableFeedback: false,
                      leading: const VmAvatar.small(),
                      title: Text(location.name),
                      subtitle: Text(location.address),
                      trailing: GestureDetector(
                        onTap: () => VmNavigator.push(context, VmPlacePage(id: 1)),
                        child: SizedBox.square(
                          dimension: 40.0,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: colors.surfaceHigh,
                              shape: BoxShape.circle,
                            ),
                            child: const Center(child: Icon(Icons.info_outline_rounded)),
                          ),
                        ),
                      ),
                      onTap: () {},
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
