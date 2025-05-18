import 'package:control/control.dart';
import 'package:vm_app/src/feature/event/controller/vm_event_state.dart';
import 'package:vm_app/src/feature/event/data/vm_event_repository.dart';
import 'package:vm_app/src/feature/event/model/event.dart';

final class VmEventController extends StateController<VmEventState> with SequentialControllerHandler {
  VmEventController({required IVmEventRepository repository})
    : _repository = repository,
      super(initialState: const VmEventState.idle());

  final IVmEventRepository _repository;

  void fetch(VmEventID id) => handle(
    () async {
      state.processing();
      await _repository.fetch(page: 1);
      setState(const VmEventState.success());
    },
    error: (e, _) async => setState(VmEventState.error(e)),
    done: () async => setState(const VmEventState.idle()),
  );

  void create(VmEvent event) => handle(
    () async {
      state.processing();
      await _repository.create(event);
      setState(const VmEventState.success());
    },
    error: (e, _) async => setState(VmEventState.error(e)),
    done: () async => setState(const VmEventState.idle()),
  );

  void update(VmEvent event) => handle(
    () async {
      state.processing();
      await _repository.update(event);
      setState(const VmEventState.success());
    },
    error: (e, _) async => setState(VmEventState.error(e)),
    done: () async => setState(const VmEventState.idle()),
  );

  void delete(VmEventID id) => handle(
    () async {
      state.processing();
      await _repository.delete(id);
      setState(const VmEventState.success());
    },
    error: (e, _) async => setState(VmEventState.error(e)),
    done: () async => setState(const VmEventState.idle()),
  );
}


/*
  1. Контроллер для списка событий на основе профиля
  2. Контроллер для поиска по фильтрам
  3. Контроллер для создания/обновления/удаления событий
  4. Контроллер для отображения одного события по ID
*/