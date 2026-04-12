import 'package:control/control.dart';
import 'package:vm_app/src/feature/event/controller/event/vm_event_state.dart';
import 'package:vm_app/src/feature/event/data/vm_event_repository.dart';
import 'package:vm_app/src/feature/event/model/event.dart';

final class VmEventController extends StateController<VmEventState> with SequentialControllerHandler {
  VmEventController({
    required this.id,
    required IVmEventRepository repository,
  }) : _repository = repository,
       super(initialState: const VmEventState.idle()) {
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

  /// {@macro vm_event.join}
  void join() => handle(
    () async {
      setState(state.processing());
      final event = await _repository.join(id);
      setState(state.success(event));
    },
    error: (e, _) async => setState(state.errorState(e)),
    done: () async => setState(state.idle()),
  );

  /// {@macro vm_event.decline}
  void decline() => handle(
    () async {
      setState(state.processing());
      final event = await _repository.decline(id);
      setState(state.success(event));
    },
    error: (e, _) async => setState(state.errorState(e)),
    done: () async => setState(state.idle()),
  );

  /// {@macro vm_event.cancel}
  void cancel() => handle(
    () async {
      setState(state.processing());
      final event = await _repository.cancel(id);
      setState(state.success(event));
    },
    error: (e, _) async => setState(state.errorState(e)),
    done: () async => setState(state.idle()),
  );

  /// {@macro vm_event.complain}
  void complain() => handle(
    () async {
      setState(state.processing());
      final event = await _repository.cancel(id);
      setState(state.success(event));
    },
    error: (e, _) async => setState(state.errorState(e)),
    done: () async => setState(state.idle()),
  );
}
