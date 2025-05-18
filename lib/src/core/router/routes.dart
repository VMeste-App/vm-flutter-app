import 'package:flutter/material.dart';
import 'package:octopus/octopus.dart';
import 'package:vm_app/src/feature/auth/widget/sign_in_screen.dart';
import 'package:vm_app/src/feature/event/widget/create_event_screen.dart';
import 'package:vm_app/src/feature/home/home_screen.dart';
import 'package:vm_app/src/shared/activity/widget/activities_screen.dart';

enum Routes with OctopusRoute {
  login('login'),
  home('home'),
  create('create'),
  selectActivity('select-activity');

  const Routes(this.name);

  @override
  final String name;

  @override
  Widget builder(BuildContext context, OctopusState state, OctopusNode node) => switch (this) {
    Routes.login => const SignInScreen(),
    Routes.home => const HomeScreen(),
    Routes.create => const CreateEventScreen(),
    Routes.selectActivity => const ActivitiesScreen(),
  };
}
