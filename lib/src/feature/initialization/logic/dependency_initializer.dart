import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vm_app/src/feature/auth/controller/auth_controller.dart';
import 'package:vm_app/src/feature/auth/data/auth_data_provider.dart';
import 'package:vm_app/src/feature/auth/data/auth_repository.dart';
import 'package:vm_app/src/feature/initialization/model/dependencies.dart';
import 'package:vm_app/src/feature/settings/controller/settings_controller.dart';
import 'package:vm_app/src/feature/settings/data/locale_data_provider.dart';
import 'package:vm_app/src/feature/settings/data/locale_repository.dart';
import 'package:vm_app/src/feature/settings/data/theme_data_provider.dart';
import 'package:vm_app/src/feature/settings/data/theme_repository.dart';
import 'package:vm_app/src/feature/settings/model/app_settings.dart';

abstract base class DependencyInitializer {
  static Future<Dependencies> run() async {
    final client = http.Client();

    final sharedPreferences = await SharedPreferences.getInstance();

    /// --- Authentication ---
    final IAuthRepository authRepository = AuthRepository(dataProvider: AuthDataProvider());
    // TODO: Fetch initial state.
    final authController = AuthController(authRepository: authRepository);

    /// --- Settings ---
    final themeRepository = ThemeRepository(dataProvider: ThemeDataProvider(sharedPreferences: sharedPreferences));
    final localeRepository = LocaleRepository(dataProvider: LocaleDataProvider(sharedPreferences: sharedPreferences));

    final theme = await themeRepository.getTheme();
    final locale = await localeRepository.getLocale();
    final settings = AppSettings(theme: theme, locale: locale);

    final settingsController = SettingsController(
      themeRepository: themeRepository,
      localeRepository: localeRepository,
      initialSettings: settings,
    );

    return Dependencies(client: client, authController: authController, settingsController: settingsController);
  }
}
