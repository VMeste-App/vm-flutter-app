import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vm_app/src/core/di/dependencies_scope.dart';
import 'package:vm_app/src/feature/auth/controller/authentication_controller.dart';
import 'package:vm_app/src/feature/event/controller/single/vm_event_controller.dart';
import 'package:vm_app/src/feature/settings/controller/settings_controller.dart';

final class Dependencies {
  /// The state from the closest instance of this class.
  factory Dependencies.of(BuildContext context) => DependenciesScope.of(context);

  final Dio client;
  // TODO: Сделать абстракцию для замены на FSS при надобности.
  final SharedPreferencesAsync sharedPreferences;

  final AuthController authController;
  final SettingsController settingsController;
  final VmEventController eventController;

  Dependencies({
    required this.client,
    required this.authController,
    required this.settingsController,
    required this.sharedPreferences,
    required this.eventController,
  });
}
