import 'dart:io';

import 'package:dio/dio.dart';
import 'package:vm_app/src/core/model/typedefs.dart';
import 'package:vm_app/src/feature/profile/model/profile.dart';

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
  Future<Profile> update();

  /// {@template profile.uploadAvatar}
  /// Добавить/обновить аватар.
  /// {@endtemplate}
  Future<Profile> uploadAvatar(ProfileId id, File file);
}

class ProfileRepository implements IProfileRepository {
  final Dio _client;

  ProfileRepository({required Dio client}) : _client = client;

  @override
  Future<Profile> getProfileById(ProfileId id) async {
    final response = await _client.get<Json>('/profile/{$id}');
    return _parseFromResponse(response);
  }

  @override
  Future<Profile> create() async {
    final response = await _client.post<Json>('/profile', data: {});
    return _parseFromResponse(response);
  }

  @override
  Future<Profile> update() async {
    final response = await _client.put<Json>('/profile', data: {});
    return _parseFromResponse(response);
  }

  @override
  Future<Profile> uploadAvatar(ProfileId id, File file) async {
    final multipartFile = MultipartFile.fromFile(file.path);
    final formData = FormData.fromMap({'photo': multipartFile});
    final response = await _client.post<Json>('/profile/{$id}/avatar', data: formData);
    return _parseFromResponse(response);
  }

  Profile _parseFromResponse(Response<Json> response) {
    if (response.data case final data?) {
      return _parseProfile(data);
    }

    throw Exception('Failed to parse data');
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
