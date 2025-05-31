import 'package:flutter/material.dart';
import 'package:vm_app/src/core/di/dependencies.dart';
import 'package:vm_app/src/core/l10n/app_localization.dart';
import 'package:vm_app/src/core/navigator/navigator.dart';
import 'package:vm_app/src/core/navigator/pages.dart';
import 'package:vm_app/src/feature/auth/widget/auth_guard.dart';
import 'package:vm_app/src/feature/settings/widget/settings_scope.dart';
import 'package:vm_app/src/shared/activity/widget/activity_scope.dart';

class VmApp extends StatefulWidget {
  const VmApp({super.key});

  @override
  State<VmApp> createState() => _VmAppState();
}

class _VmAppState extends State<VmApp> {
  // Чтобы исключить пересоздание дерева виджетов(при включении Widget Inspector, например).
  final GlobalKey<_VmAppState> _appKey = GlobalKey<_VmAppState>();

  @override
  Widget build(BuildContext context) {
    final theme = SettingsScope.themeOf(context).theme;
    final locale = SettingsScope.localeOf(context).locale;

    return MaterialApp(
      key: _appKey,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalization.localizationsDelegates,
      supportedLocales: AppLocalization.supportedLocales,
      locale: locale,
      themeMode: theme.mode,
      theme: theme.lightTheme,
      // darkTheme: theme.darkTheme,
      builder: (context, child) => MediaQuery.withNoTextScaling(
        child: AuthGuard(
          child: SettingsScope(
            controller: Dependencies.of(context).settingsController,
            child: ActivityScope(
              child: VmNavigator(
                pages: const [HomePage()],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
