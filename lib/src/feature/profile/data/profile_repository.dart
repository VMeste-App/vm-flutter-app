import 'dart:io';

import 'package:vm_app/src/core/network/vm_http_client.dart';
import 'package:vm_app/src/feature/profile/model/profile.dart';
import 'package:vm_app/src/feature/profile/model/sex.dart';

abstract interface class IProfileRepository {
  /// {@template profile.byId}
  /// Получить профиль по [id].
  /// {@endtemplate}
  Future<Profile> getProfileById(ProfileId id);

  /// {@template profile.create}
  /// Обновить данные профиля.
  /// {@endtemplate}
  Future<Profile> create();

  /// {@template profile.update}
  /// Обновить данные профиля.
  /// {@endtemplate}
  Future<Profile> update(Profile profile);

  /// {@template profile.uploadAvatar}
  /// Добавить/обновить аватар.
  /// {@endtemplate}
  Future<Profile> uploadAvatar(ProfileId id, File file);
}

class ProfileRepository implements IProfileRepository {
  final VmHttpClient _client;

  ProfileRepository({required VmHttpClient client}) : _client = client;

  @override
  Future<Profile> getProfileById(ProfileId id) async {
    return Profile(
      id: id,
      firstName: 'Иван',
      lastName: 'Иванов',
      birthDate: DateTime(1988),
      sex: Sex.male,
      email: 'test2@gmail.com',
      weight: 80,
      height: 190,
      aboutMe: 'about me',
    );

    final response = await _client.get('/profile/{$id}');
    return _parseProfile(response);
  }

  @override
  Future<Profile> create() async {
    final response = await _client.post('/profile', body: {});
    return _parseProfile(response);
  }

  @override
  Future<Profile> update(Profile profile) async {
    final response = await _client.put(
      '/profile',
      body: profile.toJson(),
    );
    return _parseProfile(response);
  }

  @override
  Future<Profile> uploadAvatar(ProfileId id, File file) async {
    final response = await _client.postMultipart(
      '/profile/{$id}/avatar',
      fieldName: 'photo',
      file: file,
    );
    return _parseProfile(response);
  }

  Profile _parseProfile(Map<String, Object?> json) => Profile.fromJson(json);
}
