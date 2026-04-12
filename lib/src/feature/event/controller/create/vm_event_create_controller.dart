import 'package:flutter/foundation.dart';
import 'package:vm_app/src/core/controller/controller.dart';
import 'package:vm_app/src/feature/event/controller/create/vm_event_create_state.dart';
import 'package:vm_app/src/feature/event/data/vm_event_repository.dart';
import 'package:vm_app/src/feature/event/model/create_event.dart';
import 'package:vm_app/src/feature/event/model/event.dart';

final class VmEventCreateController extends VmController<VmEventCreateState> {
  VmEventCreateController({
    required IVmEventRepository repository,
    required ValueListenable<VmEvent$Draft> eventChanges,
  }) : _eventChanges = eventChanges,
       _repository = repository,
       super(initialState: const VmEventCreateState.idle(VmEvent$Draft())) {
    _eventChanges.addListener(_onChange);
  }

  final IVmEventRepository _repository;
  final ValueListenable<VmEvent$Draft> _eventChanges;

  void restore(AsyncValueGetter<bool> shouldRestore) => handle(
    () async {
      setState(state.processing());
      final draft = await _repository.getDraft();
      var event = const VmEvent$Draft();
      if (draft != null) {
        final res = await shouldRestore();
        if (res) event = draft;
      }
      setState(state.idle(event));
    },
    done: () async => setState(state.idle()),
  );

  void create(VmEvent$Create event) => handle(
    () async {
      setState(state.processing());
      await Future.delayed(const Duration(seconds: 5));
      // await _repository.create(event);
      setState(state.success());
    },
    error: (e, _) async => setState(state.errorState(e)),
    done: () async => setState(state.idle()),
  );

  // TODO: Add debounce.
  void _onChange() {
    final draft = _eventChanges.value;
    setState(state.idle(draft));
    _repository.saveDraft(_eventChanges.value).ignore();
  }
}
