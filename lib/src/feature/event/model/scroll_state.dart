import 'package:meta/meta.dart';

@immutable
final class ScrollState {
  final int page;
  final bool hasMore;

  const ScrollState({
    required this.page,
    required this.hasMore,
  });

  const ScrollState.start() : this(page: 0, hasMore: true);

  ScrollState copyWith({
    int? page,
    bool? hasMore,
  }) => ScrollState(
    page: page ?? this.page,
    hasMore: hasMore ?? this.hasMore,
  );
}
