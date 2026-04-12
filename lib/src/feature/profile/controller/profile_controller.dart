import 'package:vm_app/src/core/controller/controller.dart';
import 'package:vm_app/src/feature/event/data/vm_event_repository.dart';
import 'package:vm_app/src/feature/event/model/event.dart';
import 'package:vm_app/src/feature/profile/controller/profile_state.dart';

final class ProfileController extends VmController<ProfileState> {
  ProfileController({
    required this.id,
    required IVmEventRepository repository,
  }) : _repository = repository,
       super(initialState: const ProfileState.idle()) {
    fetch();
  }

  final VmEventId id;
  final IVmEventRepository _repository;

  void fetch() => handle(
    () async {
      setState(state.processing());
      final event = await _repository.getEventById(id);
      setState(state.success(event));
    },
    error: (e, st) async => setState(state.errorState(e)),
    done: () async => setState(state.idle()),
  );

  // void update(VmEvent event) => handle(
  //   () async {
  //     setState(state.processing());
  //     final event = await _repository.update(event);
  //     setState(const VmEventState.success());
  //   },
  //   error: (e, _) async => setState(state.errorState(e)),
  //   done: () async => setState(const VmEventState.idle()),
  // );
}
