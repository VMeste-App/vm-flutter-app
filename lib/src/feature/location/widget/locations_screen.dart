import 'package:control/control.dart';
import 'package:flutter/material.dart';
import 'package:vm_app/src/core/theme/colors.dart';
import 'package:vm_app/src/core/ui-kit/button.dart';
import 'package:vm_app/src/core/ui-kit/fields/search_field.dart';
import 'package:vm_app/src/core/widget/safe_scaffold.dart';
import 'package:vm_app/src/feature/event/widget/event_card.dart';
import 'package:vm_app/src/feature/location/controller/location_controller.dart';
import 'package:vm_app/src/feature/location/controller/location_state.dart';
import 'package:vm_app/src/feature/location/data/location_repository.dart';
import 'package:vm_app/src/shared/activity/model/activity.dart';

class LocationsScreen extends StatefulWidget {
  const LocationsScreen({
    super.key,
    this.selected,
  });

  final ActivityID? selected;

  @override
  State<LocationsScreen> createState() => _LocationsScreenState();
}

class _LocationsScreenState extends State<LocationsScreen> {
  late final ValueNotifier<ActivityID?> _controller = ValueNotifier(widget.selected);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ControllerScope<LocationController>(
      () => LocationController(repository: LocationRepository())..fetch(),
      child: StateConsumer<LocationController, LocationState>(
        builder: (context, state, child) {
          return SafeScaffold(
            appBar: AppBar(title: const Text('Локация')),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: VmButton(
              stretched: false,
              onPressed: () {},
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

                    return ListTile(
                      key: ValueKey(location.id),
                      focusColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      selectedTileColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      enableFeedback: false,
                      leading: const VmAvatar(),
                      title: Text(location.name),
                      subtitle: Text(location.address),
                      trailing: const SizedBox.square(
                        dimension: 40.0,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: AppColors.neutral3,
                            shape: BoxShape.circle,
                          ),
                          child: Center(child: Icon(Icons.info_outline_rounded)),
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
