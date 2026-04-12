import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vm_app/src/core/di/dependencies_scope.dart';
import 'package:vm_app/src/feature/auth/controller/auth_controller.dart';
import 'package:vm_app/src/feature/event/data/vm_event_repository.dart';
import 'package:vm_app/src/feature/favorite/controller/favorite_controller.dart';
import 'package:vm_app/src/feature/place/data/place_repository.dart';
import 'package:vm_app/src/feature/profile/data/profile_repository.dart';
import 'package:vm_app/src/feature/settings/controller/settings_controller.dart';

final class Dependencies {
  static Dependencies of(BuildContext context) => DependenciesScope.of(context);

  final Dio client;
  // TODO: Сделать абстракцию для замены на FSS при надобности.
  final SharedPreferencesAsync sharedPreferences;

  // Auth
  final AuthController authController;

  // Settings
  final SettingsController settingsController;

  // Events
  final IVmEventRepository eventRepository;
  final FavoriteController$Event eventFavoriteController;

  // Places
  final IPlaceRepository placeRepository;
  final FavoriteController$Place placeFavoriteController;

  // Profile
  final IProfileRepository profileRepository;
  final FavoriteController$Profile profileFavoriteController;

  Dependencies({
    required this.client,
    required this.authController,
    required this.settingsController,
    required this.sharedPreferences,
    // Events
    required this.eventRepository,
    required this.eventFavoriteController,
    // Places
    required this.placeRepository,
    required this.placeFavoriteController,
    // Profile
    required this.profileRepository,
    required this.profileFavoriteController,
  });
}
