final class PagedData<T extends Object> {
  final List<T> data;
  final int page;
  final bool endReached;

  PagedData({required this.data, required this.page, required this.endReached});
}
