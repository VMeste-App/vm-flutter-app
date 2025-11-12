import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Type definition for the navigation state.
typedef NavigationState = List<Page<Object?>>;

typedef NavigationGuard = NavigationState Function(NavigationState);

/// {@template navigator}
/// AppNavigator widget.
/// {@endtemplate}
class VmNavigator extends StatefulWidget {
  /// {@macro navigator}
  VmNavigator({
    required this.pages,
    this.guards = const [],
    this.observers = const [],
    this.transitionDelegate = const DefaultTransitionDelegate<Object?>(),
    this.revalidate,
    super.key,
  }) : assert(pages.isNotEmpty, 'pages cannot be empty');

  /// The [VmNavigatorState] from the closest instance of this class
  /// that encloses the given context, if any.
  static VmNavigatorState? maybeOf(BuildContext context) => context.findAncestorStateOfType<VmNavigatorState>();

  /// The navigation state from the closest instance of this class
  /// that encloses the given context, if any.
  static NavigationState? stateOf(BuildContext context) => maybeOf(context)?.state;

  /// The navigator from the closest instance of this class
  /// that encloses the given context, if any.
  static NavigatorState? navigatorOf(BuildContext context) => maybeOf(context)?.navigator;

  /// Change the pages.
  static void change(
    BuildContext context,
    NavigationState Function(NavigationState pages) fn,
  ) => maybeOf(context)?.change(fn);

  /// Add a page to the stack.
  static void push(BuildContext context, Page<Object?> page) => change(context, (state) => [...state, page]);

  /// Pop the last page from the stack.
  static void pop(BuildContext context) => change(context, (state) {
    if (state.isNotEmpty) state.removeLast();

    return state;
  });

  /// Initial pages to display.
  final NavigationState pages;

  /// Guards to apply to the pages.
  final List<NavigationGuard> guards;

  /// Observers to attach to the navigator.
  final List<NavigatorObserver> observers;

  /// The transition delegate to use for the navigator.
  final TransitionDelegate<Object?> transitionDelegate;

  /// Revalidate the pages.
  final Listenable? revalidate;

  @override
  State<VmNavigator> createState() => VmNavigatorState();
}

/// State for widget AppNavigator.
class VmNavigatorState extends State<VmNavigator> {
  /// The current [Navigator] state (null if not yet built).
  NavigatorState? get navigator => _observer.navigator;

  /// The current pages list.
  NavigationState get state => _state;

  late NavigationState _state;
  final NavigatorObserver _observer = NavigatorObserver();
  List<NavigatorObserver> _observers = const [];

  /* #region Lifecycle */
  @override
  void initState() {
    super.initState();
    _state = widget.pages;
    widget.revalidate?.addListener(revalidate);
    _observers = <NavigatorObserver>[_observer, ...widget.observers];
  }

  @override
  void didUpdateWidget(covariant VmNavigator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!identical(widget.revalidate, oldWidget.revalidate)) {
      oldWidget.revalidate?.removeListener(revalidate);
      widget.revalidate?.addListener(revalidate);
    }
    if (!identical(widget.observers, oldWidget.observers)) {
      _observers = <NavigatorObserver>[_observer, ...widget.observers];
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget.revalidate?.removeListener(revalidate);
  }
  /* #endregion */

  /// Revalidate the pages.
  void revalidate() {
    final next = widget.guards.fold(_state.toList(), (s, g) => g(s));
    if (next.isEmpty || listEquals(next, _state)) return;
    _state = UnmodifiableListView<Page<Object?>>(next);

    setState(() {});
  }

  /// Change the pages.
  void change(NavigationState Function(NavigationState pages) fn) {
    final prev = _state.toList();
    var next = fn(prev);
    if (next.isEmpty) return;
    next = widget.guards.fold(next, (s, g) => g(s));
    if (next.isEmpty || listEquals(next, _state)) return;
    _state = UnmodifiableListView<Page<Object?>>(next);

    setState(() {});
  }

  void _onDidRemovePage(Page<Object?> page) => change((pages) => pages..remove(page));

  @override
  Widget build(BuildContext context) => Navigator(
    pages: _state,
    transitionDelegate: widget.transitionDelegate,
    onDidRemovePage: _onDidRemovePage,
    observers: _observers,
  );
}
