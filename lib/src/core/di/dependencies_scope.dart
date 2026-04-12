import 'package:flutter/widgets.dart';
import 'package:vm_app/src/core/di/dependencies.dart';
import 'package:vm_app/src/core/utils/extensions/context_extension.dart';

class DependenciesScope extends InheritedWidget {
  const DependenciesScope({
    super.key,
    required this.dependencies,
    required super.child,
  });

  final Dependencies dependencies;

  static Dependencies of(BuildContext context) => context.inhOf<DependenciesScope>(listen: false).dependencies;

  @override
  bool updateShouldNotify(DependenciesScope oldWidget) => false;
}
