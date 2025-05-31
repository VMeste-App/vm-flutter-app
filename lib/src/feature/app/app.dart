import 'package:flutter/material.dart';
import 'package:octopus/octopus.dart';
import 'package:vm_app/src/core/l10n/app_localization.dart';
import 'package:vm_app/src/core/router/router_state_mixin.dart';
import 'package:vm_app/src/feature/settings/widget/settings_scope.dart';

class VmApp extends StatefulWidget {
  const VmApp({super.key});

  @override
  State<VmApp> createState() => _VmAppState();
}

class _VmAppState extends State<VmApp> with RouterStateMixin {
  // Чтобы исключить пересоздание дерева виджетов(при включении Widget Inspector, например).
  final GlobalKey<_VmAppState> _appKey = GlobalKey<_VmAppState>();

  @override
  Widget build(BuildContext context) {
    final theme = SettingsScope.themeOf(context).theme;
    final locale = SettingsScope.localeOf(context).locale;

    return MaterialApp.router(
      key: _appKey,
      debugShowCheckedModeBanner: false,
      routerConfig: router.config,
      localizationsDelegates: AppLocalization.localizationsDelegates,
      supportedLocales: AppLocalization.supportedLocales,
      locale: locale,
      themeMode: theme.mode,
      theme: theme.lightTheme,
      // darkTheme: theme.darkTheme,
      builder: (context, child) => MediaQuery.withNoTextScaling(child: OctopusTools(child: child!)),
    );
  }
}
