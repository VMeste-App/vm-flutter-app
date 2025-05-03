import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vm_app/src/core/di/dependencies_scope.dart';
import 'package:vm_app/src/feature/auth/controller/auth_controller.dart';
import 'package:vm_app/src/feature/event/controller/vm_event_controller.dart';
import 'package:vm_app/src/feature/settings/controller/settings_controller.dart';

final class Dependencies {
  /// The state from the closest instance of this class.
  factory Dependencies.of(BuildContext context) => DependenciesScope.of(context);

  final http.Client client;
  final SharedPreferences sharedPreferences;

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
