import 'package:control/control.dart';
import 'package:vm_app/src/feature/event/controller/list/event_list_state.dart';
import 'package:vm_app/src/feature/event/data/vm_event_repository.dart';

final class EventListController extends StateController<EventListState> with SequentialControllerHandler {
  EventListController({required IVmEventRepository repository})
    : _repository = repository,
      super(initialState: const EventListState.idle());

  final IVmEventRepository _repository;

  void fetch({bool refresh = false}) => handle(
    () async {
      if (!refresh && !state.scrollState.hasMore) return;

      setState(state.processing());

      final page = refresh ? 0 : state.scrollState.page + 1;
      final events = await _repository.getEvents(page: page);

      final scrollState = events.isEmpty
          ? state.scrollState.copyWith(hasMore: events.isNotEmpty)
          : state.scrollState.copyWith(page: page);

      setState(EventListState.idle(events: events, scrollState: scrollState));
    },
    error: (e, _) async => setState(state.errorState(e)),
    done: () async => setState(const EventListState.idle()),
  );
}
