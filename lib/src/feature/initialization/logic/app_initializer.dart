import 'dart:async';

import 'package:control/control.dart';
import 'package:flutter/widgets.dart';
import 'package:vm_app/src/core/controller/controller_observer.dart';
import 'package:vm_app/src/core/di/dependencies.dart';
import 'package:vm_app/src/core/utils/log_util.dart';
import 'package:vm_app/src/feature/initialization/logic/dependency_initializer.dart';

abstract base class AppInitializer {
  static FutureOr<Dependencies> run({
    FutureOr<void> Function(Dependencies dependencies)? onSuccess,
    void Function(Object error, StackTrace stackTrace)? onError,
  }) async {
    late final WidgetsBinding widgetsBinding;

    try {
      widgetsBinding = WidgetsFlutterBinding.ensureInitialized()..deferFirstFrame();

      // Set up error handling.
      widgetsBinding.platformDispatcher.onError = LogUtils.logPlatformDispatcherError;
      FlutterError.onError = LogUtils.logFlutterError;

      // Set up controller observer.
      Controller.observer = const ControllerObserver();

      // Set up dependencies.
      final dependencies = await DependencyInitializer.run();
      await onSuccess?.call(dependencies);

      return dependencies;
    } catch (e, st) {
      onError?.call(e, st);
      rethrow;
    } finally {
      widgetsBinding.addPostFrameCallback((_) {
        widgetsBinding.allowFirstFrame(); // Closes splash screen, and show the app layout.
      });
    }
  }
}
