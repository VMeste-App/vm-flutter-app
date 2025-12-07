import 'package:control/control.dart';
import 'package:vm_app/src/feature/event/controller/create/vm_event_create_state.dart';
import 'package:vm_app/src/feature/event/data/vm_event_repository.dart';
import 'package:vm_app/src/feature/event/model/event.dart';

final class VmEventController extends StateController<VmEventCreateState> with SequentialControllerHandler {
  VmEventController({required IVmEventRepository repository})
    : _repository = repository,
      super(initialState: const VmEventCreateState.idle());

  final IVmEventRepository _repository;

  // TODO: Restore draft from backend or cache.
  // void restore();

  // TODO: Save draft to backend or cache.
  // void update();

  void create(VmEvent event) => handle(
    () async {
      state.processing();
      await _repository.create(event);
      setState(const VmEventCreateState.success());
    },
    error: (e, _) async => setState(VmEventCreateState.error(e)),
    done: () async => setState(const VmEventCreateState.idle()),
  );
}
