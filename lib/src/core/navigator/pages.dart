import 'package:flutter/material.dart';
import 'package:vm_app/src/feature/event/widget/create_event_screen.dart';
import 'package:vm_app/src/feature/home/home_screen.dart';
import 'package:vm_app/src/shared/activity/widget/activities_screen.dart';

final class VmPage<T> extends MaterialPage<T> {
  const VmPage({
    super.key,
    super.name,
    super.fullscreenDialog,
    required super.child,
  });
}

final class HomePage extends VmPage<void> {
  const HomePage()
    : super(
        key: const ValueKey('home'),
        name: 'home',
        child: const HomeScreen(),
      );
}

final class CreateEventPage extends VmPage<void> {
  const CreateEventPage()
    : super(
        key: const ValueKey('create-event'),
        name: 'create-event',
        fullscreenDialog: true,
        child: const CreateEventScreen(),
      );
}

final class ActivitiesPage extends VmPage<void> {
  const ActivitiesPage()
    : super(
        key: const ValueKey('activities'),
        name: 'activities',
        child: const ActivitiesScreen(),
      );
}
