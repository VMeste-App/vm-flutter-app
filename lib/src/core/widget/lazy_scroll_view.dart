import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum _PagedListState { processing, idle }

/// {@template lazy_load_scroll_view}
/// LazyLoadScrollView widget.
/// {@endtemplate}
class LazyScrollView extends StatefulWidget {
  /// {@macro lazy_load_scroll_view}
  const LazyScrollView({super.key, required this.child, this.onStartOfPage, this.onEndOfPage, this.scrollOffset = 100});

  /// The [Widget] that this widget watches for changes on.
  final Widget child;

  /// Called when the [child] reaches the start of the list.
  final AsyncCallback? onStartOfPage;

  /// Called when the [child] reaches the end of the list.
  final AsyncCallback? onEndOfPage;

  /// The offset to take into account when triggering [onEndOfPage]/[onStartOfPage] in pixels.
  final double scrollOffset;

  @override
  State<LazyScrollView> createState() => _LazyScrollViewState();
}

/// State for widget LazyLoadScrollView.
class _LazyScrollViewState extends State<LazyScrollView> {
  _PagedListState _pagedListState = _PagedListState.idle;
  double _scrollPosition = 0;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(onNotification: _onNotification, child: widget.child);
  }

  bool _onNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      final pixels = notification.metrics.pixels;
      final scrollOffset = widget.scrollOffset;
      final extentBefore = notification.metrics.extentBefore;
      final extentAfter = notification.metrics.extentAfter;
      final scrollingDown = _scrollPosition < pixels;
      _scrollPosition = pixels;

      if (scrollingDown) {
        if (extentAfter <= scrollOffset) {
          _onEndOfPage();
        }
      } else {
        if (extentBefore <= scrollOffset) {
          _onStartOfPage();
        }
      }

      return false;
    }

    if (notification is OverscrollNotification) {
      if (notification.overscroll > 0) {
        _onEndOfPage();
      } else if (notification.overscroll < 0) {
        _onStartOfPage();
      }

      return false;
    }

    return false;
  }

  void _onEndOfPage() => _onReachEdge(widget.onEndOfPage);

  void _onStartOfPage() => _onReachEdge(widget.onStartOfPage);

  void _onReachEdge(AsyncCallback? callback) {
    if (callback == null || _pagedListState == _PagedListState.processing) {
      return;
    }

    _pagedListState = _PagedListState.processing;
    callback().whenComplete(() => _pagedListState = _PagedListState.idle);
  }
}
