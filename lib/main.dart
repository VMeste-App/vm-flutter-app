import 'package:flutter/material.dart';
import 'package:l/l.dart';
import 'package:stack_trace/stack_trace.dart';
import 'package:vm_app/src/core/di/dependencies_scope.dart';
import 'package:vm_app/src/core/utils/log_util.dart';
import 'package:vm_app/src/feature/app/app.dart';
import 'package:vm_app/src/feature/auth/widget/authentication_scope.dart';
import 'package:vm_app/src/feature/initialization/logic/app_initializer.dart';
import 'package:vm_app/src/feature/initialization/widget/initialization_failed_screen.dart';
import 'package:vm_app/src/feature/initialization/widget/initialization_screen.dart';
import 'package:vm_app/src/feature/settings/widget/settings_scope.dart';

void main() async => l.capture<void>(
  () => Chain.capture(() {
    runApp(const InitializationScreen());

    AppInitializer.run(
      onSuccess: (dependencies) => runApp(
        DependenciesScope(
          dependencies: dependencies,
          child: AuthenticationScope(
            child: SettingsScope(
              controller: dependencies.settingsController,
              child: const VmApp(),
            ),
          ),
        ),
      ),
      onError: (e, st) {
        runApp(const InitializationFailedScreen());
        LogUtils.logInitializationError(e, st);
      },
    );
  }, onError: LogUtils.logTopLevelError),
  // TODO: Add log message formatting.
  const LogOptions(handlePrint: false),
);
