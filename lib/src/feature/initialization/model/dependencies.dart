import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:vm_app/src/feature/auth/controller/auth_controller.dart';
import 'package:vm_app/src/feature/settings/controller/settings_controller.dart';

@immutable
final class Dependencies {
  const Dependencies({required this.client, required this.authController, required this.settingsController});

  final http.Client client;
  final AuthController authController;
  final SettingsController settingsController;
}
