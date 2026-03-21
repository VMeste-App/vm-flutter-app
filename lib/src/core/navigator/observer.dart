import 'package:flutter/material.dart';
import 'package:l/l.dart';

final class VmNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    l.v6('Navigator | Push | ${_name(previousRoute)} -> ${_name(route)}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    l.v6('Navigator | Pop | ${_name(previousRoute)} -> ${_name(route)}');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    l.v6('Navigator | Remove | ${_name(previousRoute)} -> ${_name(route)}');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    l.v6('Navigator | Replace | ${_name(oldRoute)} -> ${_name(newRoute)}');
  }

  @override
  void didChangeTop(Route<dynamic> topRoute, Route<dynamic>? previousTopRoute) {
    l.v6('Navigator | Change Top | ${_name(previousTopRoute)} -> ${_name(topRoute)}');
  }

  String _name(Route<dynamic>? route) => route?.settings.name ?? route.toString();

  @override
  void didStartUserGesture(
    Route<dynamic> route,
    Route<dynamic>? previousRoute,
  ) {
    l.v6('Navigator | Start Gesture | ${_name(previousRoute)} -> ${_name(route)}');
  }

  @override
  void didStopUserGesture() {
    l.v6('Navigator | Stop Gesture ');
  }
}
