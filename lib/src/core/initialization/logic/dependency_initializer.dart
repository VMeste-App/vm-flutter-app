import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vm_app/src/core/config/config.dart';
import 'package:vm_app/src/core/di/dependencies.dart';
import 'package:vm_app/src/core/network/vm_http_client_factory.dart';
import 'package:vm_app/src/core/network/vm_http_client_options.dart';
import 'package:vm_app/src/feature/auth/controller/auth_controller.dart';
import 'package:vm_app/src/feature/auth/data/auth_repository.dart';
import 'package:vm_app/src/feature/event/data/vm_event_repository.dart';
import 'package:vm_app/src/feature/favorite/controller/favorite_controller.dart';
import 'package:vm_app/src/feature/favorite/data/favorite_local_data_source.dart';
import 'package:vm_app/src/feature/favorite/data/favorite_repository.dart';
import 'package:vm_app/src/feature/place/data/place_repository.dart';
import 'package:vm_app/src/feature/profile/data/profile_repository.dart';
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

    /// --- Authentication ---
    final authRepository = FakeAuthRepository();
    // AuthRepository(client: client, storage: sharedPreferences);
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

    // Events
    final eventRepository = VmEventRepository(client: client, sp: sharedPreferences);
    final eventFavoriteRepo = FavoriteRepository$Event(
      httpClient: client,
      localDs: FavoriteLocalDataSource('event', sp: sharedPreferences),
    );
    final eventFavoriteController = FavoriteController$Event(repository: eventFavoriteRepo);

    // Profile
    final profileRepository = ProfileRepository(client: client);
    final profileFavoriteRepo = FavoriteRepository$Profile(
      httpClient: client,
      localDs: FavoriteLocalDataSource('profile', sp: sharedPreferences),
    );
    final profileFavoriteController = FavoriteController$Profile(repository: profileFavoriteRepo);

    // Places
    final placeRepository = PlaceRepository(client: client);
    final placeFavoriteRepo = FavoriteRepository$Place(
      httpClient: client,
      localDs: FavoriteLocalDataSource('place', sp: sharedPreferences),
    );
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
