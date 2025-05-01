import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:vm_app/src/feature/initialization/model/dependencies.dart';

class DependenciesScope extends InheritedWidget {
  const DependenciesScope({required this.dependencies, required super.child, super.key});

  final Dependencies dependencies;

  /// Get the dependencies from the [context].
  static Dependencies of(BuildContext context) {
    final scope = context.getInheritedWidgetOfExactType<DependenciesScope>();
    assert(scope != null, 'DependenciesScope not found in context');

    return scope!.dependencies;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Dependencies>('dependencies', dependencies));
  }

  @override
  bool updateShouldNotify(covariant DependenciesScope oldWidget) => false;
}
