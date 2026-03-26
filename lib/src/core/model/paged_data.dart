import 'dart:collection';

class PagedData<T extends Object> extends UnmodifiableListView<T> {
  final int page;
  final bool hasMore;

  PagedData(
    super.source, {
    required this.page,
    required this.hasMore,
  });

  PagedData.empty() : page = 0, hasMore = false, super(const []);
}
