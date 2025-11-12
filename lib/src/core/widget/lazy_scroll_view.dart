import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum _PagedListState { processing, idle }

/// {@template lazy_load_scroll_view}
/// LazyLoadScrollView widget.
/// {@endtemplate}
class LazyScrollView extends StatefulWidget {
  /// {@macro lazy_load_scroll_view}
  const LazyScrollView({
    super.key,
    this.onRefresh,
    this.onLoadMore,
    this.endOffset = 100,
    this.refreshOffset = 100,
    required this.child,
  });

  /// The [Widget] that this widget watches for changes on.
  final Widget child;

  /// Called when the [child] reaches the start of the list.
  final AsyncCallback? onRefresh;

  /// Called when the [child] reaches the end of the list.
  final AsyncCallback? onLoadMore;

  /// The offset to take into account when triggering [onLoadMore] in pixels.
  final double endOffset;

  final double refreshOffset;

  @override
  State<LazyScrollView> createState() => _LazyScrollViewState();
}

/// State for widget LazyLoadScrollView.
class _LazyScrollViewState extends State<LazyScrollView> {
  _PagedListState _pagedListState = _PagedListState.idle;
  double _scrollPosition = 0;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _onNotification,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Transform.translate(
            offset: Offset(0.0, -_scrollPosition / 2),
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
              value: -_scrollPosition / 70 > 1 ? null : -_scrollPosition / 70,
              constraints: BoxConstraints.tight(const Size.square(16.0)),
            ),
          ),
          Transform.translate(
            offset: const Offset(0.0, 0),
            child: widget.child,
          ),
        ],
      ),
    );
  }

  bool _onNotification(ScrollNotification notification) {
    setState(() {});
    if (notification is ScrollUpdateNotification) {
      final pixels = notification.metrics.pixels;
      final scrollOffset = widget.endOffset;
      final extentBefore = notification.metrics.extentBefore;
      final extentAfter = notification.metrics.extentAfter;
      final scrollingDown = _scrollPosition < pixels;
      _scrollPosition = pixels;

      if (scrollingDown) {
        if (extentAfter <= scrollOffset) {
          _onLoadMore();
        }
      } else {
        if (extentBefore <= scrollOffset) {
          _onRefresh();
        }
      }

      return false;
    }

    if (notification is OverscrollNotification) {
      if (notification.overscroll > 0) {
        _onLoadMore();
      } else if (notification.overscroll < 0) {
        _onRefresh();
      }

      return false;
    }

    return false;
  }

  void _onLoadMore() => _onReachEdge(widget.onLoadMore);

  void _onRefresh() => _onReachEdge(widget.onRefresh);

  void _onReachEdge(AsyncCallback? callback) {
    if (callback == null || _pagedListState == _PagedListState.processing) {
      return;
    }

    _pagedListState = _PagedListState.processing;
    callback().whenComplete(() => _pagedListState = _PagedListState.idle);
  }
}
