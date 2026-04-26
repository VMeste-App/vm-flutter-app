import 'dart:io';

import 'package:vm_app/src/core/initialization/fake/data/fake_data.dart';
import 'package:vm_app/src/feature/profile/data/profile_repository.dart';
import 'package:vm_app/src/feature/profile/model/profile.dart';

final class FakeProfileRepository implements IProfileRepository {
  final List<Profile> _profiles = [...FakeData.profiles];

  @override
  Future<Profile> getProfileById(ProfileId id) async {
    return _profiles.firstWhere((profile) => profile.id == id);
  }

  @override
  Future<Profile> create() async {
    final profile = FakeData.profiles.first.copyWith(email: 'new.fake@example.com');
    _profiles.add(profile);
    return profile;
  }

  @override
  Future<Profile> update(Profile profile) async {
    final index = _profiles.indexWhere((item) => item.id == profile.id);
    if (index == -1) {
      _profiles.add(profile);
      return profile;
    }
    _profiles[index] = profile;
    return profile;
  }

  @override
  Future<Profile> uploadAvatar(ProfileId id, File file) async {
    final profile = await getProfileById(id);
    final updatedProfile = profile.copyWith(photoUrl: file.path);
    await update(updatedProfile);
    return updatedProfile;
  }
}
