import 'package:flutter/widgets.dart';
import 'package:vm_app/src/core/di/dependencies.dart';

/// {@template inherited_dependencies}
/// InheritedDependencies widget.
/// {@endtemplate}
class DependenciesScope extends InheritedWidget {
  /// {@macro inherited_dependencies}
  const DependenciesScope({super.key, required this.dependencies, required super.child});

  final Dependencies dependencies;

  /// The state from the closest instance of this class
  /// that encloses the given context, if any.
  /// e.g. `InheritedDependencies.maybeOf(context)`.
  static Dependencies? maybeOf(BuildContext context) =>
      (context.getElementForInheritedWidgetOfExactType<DependenciesScope>()?.widget as DependenciesScope?)
          ?.dependencies;

  static Never _notFoundInheritedWidgetOfExactType() =>
      throw ArgumentError(
        'Out of scope, not found inherited widget '
            'a InheritedDependencies of the exact type',
        'out_of_scope',
      );

  /// The state from the closest instance of this class
  /// that encloses the given context.
  /// e.g. `InheritedDependencies.of(context)`
  static Dependencies of(BuildContext context) => maybeOf(context) ?? _notFoundInheritedWidgetOfExactType();

  @override
  bool updateShouldNotify(DependenciesScope oldWidget) => false;
}
