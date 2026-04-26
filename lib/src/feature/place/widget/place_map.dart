import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:vm_app/src/core/navigator/navigator.dart';
import 'package:yandex_maps_mapkit_lite/mapkit.dart' hide Icon;
import 'package:yandex_maps_mapkit_lite/mapkit_factory.dart';
import 'package:yandex_maps_mapkit_lite/yandex_map.dart';

class PlaceMapScreen extends StatefulWidget {
  const PlaceMapScreen({super.key});

  @override
  State<PlaceMapScreen> createState() => _PlaceMapScreenState();
}

class _PlaceMapScreenState extends State<PlaceMapScreen> {
  MapWindow? _mapWindow;

  @override
  void initState() {
    super.initState();
    mapkit.onStart();

    WidgetsBinding.instance.addPersistentFrameCallback((_) {
      _mapWindow?.map.logo
        ?..setAlignment(const LogoAlignment(LogoHorizontalAlignment.Left, LogoVerticalAlignment.Bottom))
        ..setPadding(const LogoPadding(horizontalPadding: 55, verticalPadding: 20));
      _mapWindow?.map.nightModeEnabled = true;
      _mapWindow?.map.move(
        const CameraPosition(Point(latitude: 56.816735, longitude: 60.635779), zoom: 17.0, azimuth: 150.0, tilt: 30.0),
      );
      // Future.delayed(Duration)
    });
  }

  @override
  void dispose() {
    super.dispose();
    mapkit.onStop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: VmButton(
        stretched: false,
        onPressed: () => VmNavigator.pop(context),
        icon: const Icon(Icons.format_list_bulleted_rounded),
        child: const Text('Списком'),
      ),
      body: Stack(
        children: [
          YandexMap(
            onMapCreated: (mapWindow) => _mapWindow = mapWindow,
          ),
          PositionedDirectional(
            start: 16.0,
            child: SafeArea(
              child: VmButton(
                stretched: false,
                icon: const Icon(
                  Icons.chevron_left_rounded,
                  color: Colors.white,
                ),
                child: Container(),
                onPressed: () => VmNavigator.pop(context),
              ),
            ),
          ),
          const PositionedDirectional(
            end: 16.0,
            bottom: 90.0,
            child: _ZoomControl(),
          ),
        ],
      ),
    );
  }
}

class _ZoomControl extends StatelessWidget {
  const _ZoomControl();

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12.0,
      children: [
        VmButton(
          stretched: false,
          onPressed: () {},
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        VmButton(
          stretched: false,
          onPressed: () {},
          child: const Icon(
            Icons.remove,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
