import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:vm_app/src/core/navigator/navigator.dart';
import 'package:vm_app/src/core/navigator/pages.dart';
import 'package:vm_app/src/core/utils/extensions/context_extension.dart';
import 'package:vm_app/src/core/utils/extensions/locale_extension.dart';
import 'package:vm_app/src/feature/settings/widget/about_app_screen.dart';
import 'package:vm_app/src/feature/settings/widget/locale_screen.dart';
import 'package:vm_app/src/feature/settings/widget/settings_scope.dart';
import 'package:vm_app/src/feature/settings/widget/theme_mode_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return VmScaffold(
      appBar: AppBar(title: Text(context.l10n.settings)),
      body: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ThemeModeTile(),
          _LocaleTile(),
          _AboutAppTile(),
        ],
      ),
    );
  }
}

class _AboutAppTile extends StatelessWidget {
  const _AboutAppTile();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('О приложении'),
      trailing: const Icon(Icons.chevron_right_outlined),
      onTap: () => VmNavigator.push(context, const VmPage(child: AboutAppScreen())),
    );
  }
}

class _ThemeModeTile extends StatelessWidget {
  const _ThemeModeTile();

  @override
  Widget build(BuildContext context) {
    final themeMode = SettingsScope.themeModeOf(context);

    return ListTile(
      title: Text(context.l10n.themeModeTitle),
      trailing: Text(themeMode.localize(context)),
      onTap: () => VmNavigator.push(context, const VmPage(child: ThemeModeScreen())),
    );
  }
}

class _LocaleTile extends StatelessWidget {
  const _LocaleTile();

  @override
  Widget build(BuildContext context) {
    final locale = SettingsScope.localeOf(context);

    return ListTile(
      title: Text(context.l10n.localeTitle),
      trailing: Text(locale.label),
      onTap: () => VmNavigator.push(context, const VmPage(child: LocaleScreen())),
    );
  }
}
