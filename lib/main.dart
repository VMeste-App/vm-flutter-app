import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skill/flutter_skill.dart';
import 'package:l/l.dart';
import 'package:stack_trace/stack_trace.dart';
import 'package:vm_app/src/core/app/app.dart';
import 'package:vm_app/src/core/di/dependencies_scope.dart';
import 'package:vm_app/src/core/initialization/logic/app_initializer.dart';
import 'package:vm_app/src/core/initialization/widget/initialization_failed_screen.dart';
import 'package:vm_app/src/core/initialization/widget/initialization_screen.dart';
import 'package:vm_app/src/core/utils/log_util.dart';

void main() async => l.capture<void>(
  () => Chain.capture(() {
    if (kDebugMode) FlutterSkillBinding.ensureInitialized();
    runApp(const InitializationScreen());

    AppInitializer.run(
      onSuccess: (dependencies) => runApp(
        DependenciesScope(
          dependencies: dependencies,
          child: const VmApp(),
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
