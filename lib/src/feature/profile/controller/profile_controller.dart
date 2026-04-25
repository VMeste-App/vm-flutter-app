import 'dart:io';

import 'package:vm_app/src/core/controller/controller.dart';
import 'package:vm_app/src/feature/event/model/event.dart';
import 'package:vm_app/src/feature/profile/controller/profile_state.dart';
import 'package:vm_app/src/feature/profile/data/profile_repository.dart';
import 'package:vm_app/src/feature/profile/model/profile.dart';

final class ProfileController extends VmController<ProfileState> {
  ProfileController({
    required this.id,
    required IProfileRepository repository,
  }) : _repository = repository,
       super(initialState: const ProfileState.idle());

  final VmEventId id;
  final IProfileRepository _repository;

  void fetch() => handle(
    () async {
      setState(state.processing());
      final profile = await _repository.getProfileById(id);
      setState(state.success(profile));
    },
    error: (e, st) async => setState(state.errorState(e)),
    done: () async => setState(state.idle()),
  );

  void update(Profile profile) => handle(
    () async {
      setState(state.processing());
      final newProfile = await _repository.update(profile);
      setState(state.success(newProfile));
    },
    error: (e, _) async => setState(state.errorState(e)),
    done: () async => setState(state.idle()),
  );

  void uploadAvatar(File file) => handle(
    () async {
      setState(state.processing());
      final newProfile = await _repository.uploadAvatar(id, file);
      setState(state.success(newProfile));
    },
    error: (e, _) async => setState(state.errorState(e)),
    done: () async => setState(state.idle()),
  );
}
