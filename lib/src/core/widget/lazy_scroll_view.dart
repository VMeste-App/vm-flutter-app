import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum _PagedListState {
  idle,
  loading
  ;

  bool get isProcessing => this == _PagedListState.loading;
}

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
  final _pagedListState = ValueNotifier<_PagedListState>(_PagedListState.idle);
  final _scrollPosition = ValueNotifier<double>(0.0);

  @override
  void dispose() {
    _pagedListState.dispose();
    _scrollPosition.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomMultiChildLayout(
      delegate: _LazyScrollViewLayoutDelegate(
        relayout: _scrollPosition,
        scroll: _scrollPosition,
        state: _pagedListState,
      ),
      children: [
        LayoutId(
          id: 'refreshIndicator',
          child: ListenableBuilder(
            listenable: Listenable.merge([_scrollPosition, _pagedListState]),
            builder: (context, child) {
              final loading = -_scrollPosition.value / 100 > 1 || _pagedListState.value.isProcessing;

              return CircularProgressIndicator(
                strokeWidth: 2.0,
                value: loading ? null : -_scrollPosition.value / 100,
                constraints: BoxConstraints.tight(const Size.square(16.0)),
              );
            },
          ),
        ),
        LayoutId(
          id: 'scrollView',
          child: NotificationListener<ScrollNotification>(
            onNotification: _onNotification,
            child: widget.child,
          ),
        ),
      ],
    );
  }

  bool _onNotification(ScrollNotification notification) {
    // setState(() {});

    // final json = {
    //   'pixels': notification.metrics.pixels,
    //   'maxScrollExtent': notification.metrics.maxScrollExtent,
    //   'minScrollExtent': notification.metrics.minScrollExtent,
    //   'extentBefore': notification.metrics.extentBefore,
    //   'extentAfter': notification.metrics.extentAfter,
    //   'viewportDimension': notification.metrics.viewportDimension,
    //   'axisDirection': notification.metrics.axisDirection,
    //   'devicePixelRatio': notification.metrics.devicePixelRatio,
    //   'atEdge': notification.metrics.atEdge,
    //   'extentInside': notification.metrics.extentInside,
    //   'extentTotal': notification.metrics.extentTotal,
    // };

    // print(json);

    final pixels = notification.metrics.pixels;
    _scrollPosition.value = notification.metrics.pixels;

    if (pixels < -widget.refreshOffset) {
      _onRefresh();
    }

    if (notification is ScrollUpdateNotification) {
      // final pixels = notification.metrics.pixels;
      // final scrollOffset = widget.endOffset;
      // // final extentBefore = notification.metrics.extentBefore;
      // // final extentAfter = notification.metrics.extentAfter;
      // final scrollingDown = _scrollPosition < pixels;
      // _scrollPosition = pixels;

      // if (pixels < -widget.refreshOffset) {
      //   _onRefresh();
      // }

      // if (scrollingDown) {
      //   if (extentAfter <= scrollOffset) {
      //     _onLoadMore();
      //   }
      // } else {
      //   if (extentBefore <= scrollOffset) {
      //     debugPrint('refresh');
      //     _onRefresh();
      //   }
      // }

      return false;
    }

    // if (notification is OverscrollNotification) {
    //   print('overscroll: ${notification.overscroll}');
    //   if (notification.overscroll > 0) {
    //     _onLoadMore();
    //   } else if (notification.overscroll < 0) {
    //     print(notification.overscroll);
    //     _onRefresh();
    //   }

    //   return false;
    // }

    return false;
  }

  void _onLoadMore() => _onReachEdge(widget.onLoadMore);

  void _onRefresh() => _onReachEdge(widget.onRefresh);

  void _onReachEdge(AsyncCallback? callback) {
    if (callback == null || _pagedListState.value == _PagedListState.loading) {
      return;
    }

    debugPrint('processing');

    _pagedListState.value = _PagedListState.loading;
    callback().whenComplete(() => _pagedListState.value = _PagedListState.idle);
  }
}

class _LazyScrollViewLayoutDelegate extends MultiChildLayoutDelegate {
  final ValueListenable<double> _scroll;
  final ValueListenable<_PagedListState> _state;

  _LazyScrollViewLayoutDelegate({
    super.relayout,
    required ValueListenable<double> scroll,
    required ValueListenable<_PagedListState> state,
  }) : _scroll = scroll,
       _state = state;

  @override
  void performLayout(Size size) {
    final rect = Offset.zero & size;

    final scroll = min(_scroll.value, 0.0).abs();

    final refreshIndicator = layoutChild(
      'refreshIndicator',
      BoxConstraints.loose(Size(rect.width, max(scroll, 16.0))),
    );

    print(scroll);
    final refreshIndicatorBoxHeight = max(scroll, _state.value.isProcessing ? 100.0 : 0.0);

    positionChild(
      'refreshIndicator',
      Offset((rect.width - refreshIndicator.width) / 2, (refreshIndicatorBoxHeight - refreshIndicator.height) / 2),
    );

    layoutChild(
      'scrollView',
      BoxConstraints.expand(width: rect.width, height: rect.bottom),
    );

    positionChild('scrollView', Offset(0.0, _state.value.isProcessing ? refreshIndicatorBoxHeight : 0.0));
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) => false;
}
