import 'package:control/control.dart';
import 'package:vm_app/src/feature/event/data/vm_event_repository.dart';
import 'package:vm_app/src/feature/search/controller/search_state.dart';

final class SearchController extends StateController<SearchState> with SequentialControllerHandler {
  SearchController({required IVmEventRepository repository})
    : _repository = repository,
      super(initialState: const SearchState.idle());

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

      setState(SearchState.idle(events: events, scrollState: scrollState));
    },
    error: (e, _) async => setState(state.errorState(e)),
    done: () async => setState(const SearchState.idle()),
  );
}
