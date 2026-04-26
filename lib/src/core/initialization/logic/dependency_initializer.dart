import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vm_app/src/core/config/config.dart';
import 'package:vm_app/src/core/di/dependencies.dart';
import 'package:vm_app/src/core/initialization/logic/dependency_factory.dart';
import 'package:vm_app/src/core/network/vm_http_client_factory.dart';
import 'package:vm_app/src/core/network/vm_http_client_options.dart';
import 'package:vm_app/src/feature/auth/controller/auth_controller.dart';
import 'package:vm_app/src/feature/favorite/controller/favorite_controller.dart';
import 'package:vm_app/src/feature/settings/controller/settings_controller.dart';
import 'package:vm_app/src/feature/settings/data/locale_data_provider.dart';
import 'package:vm_app/src/feature/settings/data/locale_repository.dart';
import 'package:vm_app/src/feature/settings/data/theme_data_provider.dart';
import 'package:vm_app/src/feature/settings/data/theme_repository.dart';
import 'package:vm_app/src/feature/settings/model/app_settings.dart';

abstract base class DependencyInitializer {
  static Future<Dependencies> run() async {
    final client = VmHttpClientFactory.create(
      VmHttpClientOptions(
        baseUri: Uri.parse(AppConfig.apiUrl),
        proxy: AppConfig.proxy,
      ),
    );

    final sharedPreferences = SharedPreferencesAsync();
    final dependencyFactory = DependencyFactory(
      environment: AppConfig.environment,
      client: client,
      sharedPreferences: sharedPreferences,
    );

    /// --- Authentication ---
    final authRepository = dependencyFactory.createAuthRepository();
    final user = await authRepository.restore();
    final authController = AuthController(authRepository: authRepository, user: user);

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

    /// --- Events ---
    final eventRepository = dependencyFactory.createEventRepository();
    final eventFavoriteRepo = dependencyFactory.createEventFavoriteRepository();
    final eventFavoriteController = FavoriteController$Event(repository: eventFavoriteRepo);

    /// --- Profile ---
    final profileRepository = dependencyFactory.createProfileRepository();
    final profileFavoriteRepo = dependencyFactory.createProfileFavoriteRepository();
    final profileFavoriteController = FavoriteController$Profile(repository: profileFavoriteRepo);

    /// --- Places ---
    final placeRepository = dependencyFactory.createPlaceRepository();
    final placeFavoriteRepo = dependencyFactory.createPlaceFavoriteRepository();
    final placeFavoriteController = FavoriteController$Place(repository: placeFavoriteRepo);

    return Dependencies(
      client: client,
      authController: authController,
      settingsController: settingsController,
      sharedPreferences: sharedPreferences,
      // Events
      eventRepository: eventRepository,
      eventFavoriteController: eventFavoriteController,
      // Places
      placeRepository: placeRepository,
      placeFavoriteController: placeFavoriteController,
      // Profile
      profileRepository: profileRepository,
      profileFavoriteController: profileFavoriteController,
    );
  }
}
