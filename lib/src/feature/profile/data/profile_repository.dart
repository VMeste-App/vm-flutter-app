import 'dart:io';

import 'package:vm_app/src/core/model/typedefs.dart';
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
    final response = await _client.put('/profile', body: {});
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

  Profile _parseProfile(Json json) {
    if (json case {
      'id': final ProfileId id,
      'first_name': final String firstName,
      'last_name': final String lastName,
      'birth_date': final String birthDate,
      'sex': final SexId sexId,
      'email': final String email,
      'weight': final int? weight,
      'height': final int? height,
      'photo_url': final String? photoUrl,
      'blurhash': final String? blurhash,
    }) {
      return Profile(
        id: id,
        firstName: firstName,
        lastName: lastName,
        birthDate: DateTime.parse(birthDate),
        sex: Sex.byId(sexId),
        email: email,
        weight: weight,
        height: height,
        photoUrl: photoUrl,
        blurhash: blurhash,
      );
    }

    throw Exception('Failed to parse profile');
  }
}
