import 'package:control/control.dart';
import 'package:vm_app/src/feature/event/create/controller/vm_event_create_state.dart';
import 'package:vm_app/src/feature/event/create/model/create_event.dart';
import 'package:vm_app/src/feature/event/data/vm_event_repository.dart';

final class VmEventCreateController extends StateController<VmEventCreateState> with SequentialControllerHandler {
  VmEventCreateController({
    required IVmEventRepository repository,
  }) : _repository = repository,
       super(initialState: const VmEventCreateState.idle());

  final IVmEventRepository _repository;

  // TODO: Restore draft from backend or cache.
  // void restore();

  // TODO: Save draft to backend or cache.
  // void update();

  void create(VmEvent$Create event) => handle(
    () async {
      setState(state.processing());
      await Future.delayed(const Duration(seconds: 5));
      // await _repository.create(event);
      setState(const VmEventCreateState.success());
    },
    error: (e, _) async => setState(VmEventCreateState.error(e)),
    done: () async => setState(const VmEventCreateState.idle()),
  );
}
