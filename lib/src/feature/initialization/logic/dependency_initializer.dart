import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vm_app/src/core/config/config.dart';
import 'package:vm_app/src/core/di/dependencies.dart';
import 'package:vm_app/src/feature/auth/controller/authentication_controller.dart';
import 'package:vm_app/src/feature/auth/data/auth_repository.dart';
import 'package:vm_app/src/feature/auth/model/user.dart';
import 'package:vm_app/src/feature/event/controller/vm_event_controller.dart';
import 'package:vm_app/src/feature/event/data/vm_event_repository.dart';
import 'package:vm_app/src/feature/settings/controller/settings_controller.dart';
import 'package:vm_app/src/feature/settings/data/locale_data_provider.dart';
import 'package:vm_app/src/feature/settings/data/locale_repository.dart';
import 'package:vm_app/src/feature/settings/data/theme_data_provider.dart';
import 'package:vm_app/src/feature/settings/data/theme_repository.dart';
import 'package:vm_app/src/feature/settings/model/app_settings.dart';

abstract base class DependencyInitializer {
  static Future<Dependencies> run() async {
    // ignore: avoid_redundant_argument_values
    final client = Dio(BaseOptions(baseUrl: AppConfig.apiUrl))
      ..httpClientAdapter = IOHttpClientAdapter(
        createHttpClient: () => HttpClient()..findProxy = (_) => 'PROXY ${AppConfig.proxy}',
      );

    final sharedPreferences = await SharedPreferences.getInstance();

    /// --- Authentication ---
    final IAuthRepository authRepository = AuthRepository(client: client, storage: sharedPreferences);
    final authController = AuthController(
      authRepository: authRepository,
      user: const User(id: 123, email: 'email'),
    );

    /// --- Settings ---
    final themeRepository = ThemeRepository(dataProvider: ThemeDataProvider(sharedPreferences: sharedPreferences));
    final localeRepository = LocaleRepository(dataProvider: LocaleDataProvider(sharedPreferences: sharedPreferences));

    final themeMode = await themeRepository.getThemeMode();
    final locale = await localeRepository.getLocale();
    final settings = AppSettings(themeMode: themeMode, locale: locale);

    final settingsController = SettingsController(
      themeRepository: themeRepository,
      localeRepository: localeRepository,
      initialSettings: settings,
    );

    /// --- Event ---
    final eventRepository = VmEventRepository(client: client);
    final eventController = VmEventController(repository: eventRepository);

    return Dependencies(
      client: client,
      authController: authController,
      settingsController: settingsController,
      sharedPreferences: sharedPreferences,
      eventController: eventController,
    );
  }
}
