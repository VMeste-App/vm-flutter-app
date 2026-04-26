import 'package:shared_preferences/shared_preferences.dart';
import 'package:vm_app/src/core/config/config.dart';
import 'package:vm_app/src/core/initialization/fake/repository/fake_auth_repository.dart';
import 'package:vm_app/src/core/initialization/fake/repository/fake_event_repository.dart';
import 'package:vm_app/src/core/initialization/fake/repository/fake_favorite_repository.dart';
import 'package:vm_app/src/core/initialization/fake/repository/fake_place_repository.dart';
import 'package:vm_app/src/core/initialization/fake/repository/fake_profile_repository.dart';
import 'package:vm_app/src/core/network/vm_http_client.dart';
import 'package:vm_app/src/feature/auth/data/auth_repository.dart';
import 'package:vm_app/src/feature/event/data/vm_event_repository.dart';
import 'package:vm_app/src/feature/event/model/event.dart';
import 'package:vm_app/src/feature/favorite/data/favorite_local_data_source.dart';
import 'package:vm_app/src/feature/favorite/data/favorite_repository.dart';
import 'package:vm_app/src/feature/place/data/place_repository.dart';
import 'package:vm_app/src/feature/place/model/place.dart';
import 'package:vm_app/src/feature/profile/data/profile_repository.dart';
import 'package:vm_app/src/feature/profile/model/profile.dart';

abstract interface class DependencyFactory {
  factory DependencyFactory({
    required AppEnvironment environment,
    required VmHttpClient client,
    required SharedPreferencesAsync sharedPreferences,
  }) {
    return switch (environment) {
      AppEnvironment.fake => _FakeDependencyFactory(sharedPreferences: sharedPreferences),
      AppEnvironment.test || AppEnvironment.prod => _RealDependencyFactory(
        client: client,
        sharedPreferences: sharedPreferences,
      ),
    };
  }

  IAuthRepository createAuthRepository();

  IVmEventRepository createEventRepository();

  IFavoriteRepository$Event createEventFavoriteRepository();

  IProfileRepository createProfileRepository();

  IFavoriteRepository$Profile createProfileFavoriteRepository();

  IPlaceRepository createPlaceRepository();

  IFavoriteRepository$Place createPlaceFavoriteRepository();
}

final class _RealDependencyFactory implements DependencyFactory {
  final VmHttpClient _client;
  final SharedPreferencesAsync _sharedPreferences;

  _RealDependencyFactory({
    required VmHttpClient client,
    required SharedPreferencesAsync sharedPreferences,
  }) : _client = client,
       _sharedPreferences = sharedPreferences;

  @override
  IAuthRepository createAuthRepository() {
    return AuthRepository(client: _client, storage: _sharedPreferences);
  }

  @override
  IVmEventRepository createEventRepository() {
    return VmEventRepository(client: _client, sp: _sharedPreferences);
  }

  @override
  IFavoriteRepository$Event createEventFavoriteRepository() {
    return FavoriteRepository$Event(
      httpClient: _client,
      localDs: FavoriteLocalDataSource<VmEventId>('event', sp: _sharedPreferences),
    );
  }

  @override
  IProfileRepository createProfileRepository() {
    return ProfileRepository(client: _client);
  }

  @override
  IFavoriteRepository$Profile createProfileFavoriteRepository() {
    return FavoriteRepository$Profile(
      httpClient: _client,
      localDs: FavoriteLocalDataSource<ProfileId>('profile', sp: _sharedPreferences),
    );
  }

  @override
  IPlaceRepository createPlaceRepository() {
    return PlaceRepository(client: _client);
  }

  @override
  IFavoriteRepository$Place createPlaceFavoriteRepository() {
    return FavoriteRepository$Place(
      httpClient: _client,
      localDs: FavoriteLocalDataSource<PlaceId>('place', sp: _sharedPreferences),
    );
  }
}

final class _FakeDependencyFactory implements DependencyFactory {
  final SharedPreferencesAsync _sharedPreferences;

  _FakeDependencyFactory({required SharedPreferencesAsync sharedPreferences}) : _sharedPreferences = sharedPreferences;

  @override
  IAuthRepository createAuthRepository() {
    return FakeAuthRepository();
  }

  @override
  IVmEventRepository createEventRepository() {
    return FakeVmEventRepository();
  }

  @override
  IFavoriteRepository$Event createEventFavoriteRepository() {
    return FakeFavoriteRepository$Event(
      localDs: FavoriteLocalDataSource<VmEventId>('event', sp: _sharedPreferences),
    );
  }

  @override
  IProfileRepository createProfileRepository() {
    return FakeProfileRepository();
  }

  @override
  IFavoriteRepository$Profile createProfileFavoriteRepository() {
    return FakeFavoriteRepository$Profile(
      localDs: FavoriteLocalDataSource<ProfileId>('profile', sp: _sharedPreferences),
    );
  }

  @override
  IPlaceRepository createPlaceRepository() {
    return FakePlaceRepository();
  }

  @override
  IFavoriteRepository$Place createPlaceFavoriteRepository() {
    return FakeFavoriteRepository$Place(
      localDs: FavoriteLocalDataSource<PlaceId>('place', sp: _sharedPreferences),
    );
  }
}
