import 'package:flutter/material.dart';
import 'package:vm_app/src/feature/auth/widget/sign_in_screen.dart';
import 'package:vm_app/src/feature/auth/widget/sign_up_screen.dart';
import 'package:vm_app/src/feature/event/model/event.dart';
import 'package:vm_app/src/feature/event/widget/create/create_event_screen.dart';
import 'package:vm_app/src/feature/event/widget/event_screen.dart';
import 'package:vm_app/src/feature/home/home_screen.dart';
import 'package:vm_app/src/feature/place/model/place.dart';
import 'package:vm_app/src/feature/place/widget/place_map.dart';
import 'package:vm_app/src/feature/place/widget/place_screen.dart';
import 'package:vm_app/src/feature/place/widget/places_screen.dart';
import 'package:vm_app/src/feature/profile/model/profile.dart';
import 'package:vm_app/src/feature/profile/widget/profile_edit_screen.dart';
import 'package:vm_app/src/feature/profile/widget/profile_screen.dart';
import 'package:vm_app/src/feature/search/widget/filter_screen.dart';
import 'package:vm_app/src/shared/activity/widget/activities_screen.dart';

final class VmPage<T> extends MaterialPage<T> {
  const VmPage({
    super.key,
    super.name,
    super.fullscreenDialog,
    required super.child,
  });
}

final class SignUpPage extends VmPage<void> {
  const SignUpPage()
    : super(
        key: const ValueKey('sign-up'),
        name: 'sign-up',
        child: const SignUpScreen(),
      );
}

final class SignInPage extends VmPage<void> {
  const SignInPage()
    : super(
        key: const ValueKey('sign-in'),
        name: 'sign-in',
        child: const SignInScreen(),
      );
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
        key: const ValueKey('create'),
        name: 'create',
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

final class FilterPage extends VmPage<void> {
  const FilterPage()
    : super(
        key: const ValueKey('filter'),
        name: 'filter',
        fullscreenDialog: true,
        child: const FilterScreen(),
      );
}

final class VmEventPage extends VmPage<void> {
  VmEventPage({required this.id})
    : super(
        key: const ValueKey('filter'),
        name: 'filter',
        child: VmEventScreen(id: id),
      );

  final VmEventId id;
}

final class VmPlacesPage extends VmPage<void> {
  const VmPlacesPage()
    : super(
        key: const ValueKey('places'),
        name: 'places',
        child: const PlacesScreen(),
      );
}

final class VmPlacePage extends VmPage<void> {
  VmPlacePage({required this.id})
    : super(
        key: const ValueKey('place'),
        name: 'place',
        child: PlaceScreen(id: id),
      );

  final PlaceId id;
}

final class VmPlacesMapPage extends VmPage<void> {
  const VmPlacesMapPage()
    : super(
        key: const ValueKey('places-map'),
        name: 'places-map',
        // fullscreenDialog: true,
        child: const PlaceMapScreen(),
      );
}

final class ProfilePage extends VmPage<void> {
  ProfilePage({required this.id})
    : super(
        key: const ValueKey('profile'),
        name: 'profile',
        // fullscreenDialog: true,
        child: ProfileScreen(id: id),
      );

  final ProfileId id;
}

final class ProfileEditPage extends VmPage<void> {
  ProfileEditPage({required this.id})
    : super(
        key: const ValueKey('profile-edit'),
        name: 'profile-edit',
        // fullscreenDialog: true,
        child: ProfileEditScreen(id: id),
      );

  final ProfileId id;
}
