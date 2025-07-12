import 'package:flutter/material.dart';
import 'package:vm_app/src/core/l10n/app_localization.dart';
import 'package:vm_app/src/core/utils/extensions/context_extension.dart';
import 'package:vm_app/src/core/utils/extensions/locale_extension.dart';
import 'package:vm_app/src/feature/auth/widget/auth_scope.dart';
import 'package:vm_app/src/feature/settings/widget/settings_scope.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _ThemeModeButton(),
            _LanguageButton(),
            _LogoutButton(),
          ],
        ),
      ),
    );
  }
}

class _ThemeModeButton extends StatelessWidget {
  const _ThemeModeButton();

  static const List<ThemeMode> _modes = [ThemeMode.system, ThemeMode.light, ThemeMode.dark];

  @override
  Widget build(BuildContext context) {
    final themeMode = SettingsScope.themeOf(context).theme.mode;

    return PopupMenuButton(
      icon: Icon(Icons.dark_mode_outlined, color: Theme.of(context).colorScheme.onSurfaceVariant),
      tooltip: context.l10n.theme_button_tooltip,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      itemBuilder: (context) {
        return List.generate(_modes.length, (index) {
          final currentMode = _modes[index];

          return PopupMenuItem(
            value: index,
            enabled: currentMode != themeMode,
            child: ListTile(title: Text(currentMode.toString())),
          );
        });
      },
      onSelected: (index) => _changeThemeMode(context, mode: _modes[index]),
    );
  }

  void _changeThemeMode(BuildContext context, {required ThemeMode mode}) {
    SettingsScope.themeOf(context).setThemeMode(mode);
  }
}

class _LanguageButton extends StatelessWidget {
  const _LanguageButton();

  @override
  Widget build(BuildContext context) {
    const supportedLocales = AppLocalization.supportedLocales;
    final selectedLocale = SettingsScope.localeOf(context).locale;

    return PopupMenuButton(
      icon: Icon(Icons.language, color: Theme.of(context).colorScheme.onSurfaceVariant),
      tooltip: 'Select a language',
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      itemBuilder: (context) {
        return List.generate(supportedLocales.length, (index) {
          final currentLocale = supportedLocales[index];

          return PopupMenuItem(
            value: index,
            enabled: currentLocale != selectedLocale,
            child: ListTile(title: Text(currentLocale.label)),
          );
        });
      },
      onSelected: (index) => _changeSeedColor(context, locale: supportedLocales[index]),
    );
  }

  void _changeSeedColor(BuildContext context, {required Locale locale}) {
    SettingsScope.localeOf(context).setLocale(locale);
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton();

  @override
  Widget build(BuildContext context) {
    final controller = AuthScope.controllerOf(context);

    return IconButton(onPressed: controller.signOut, icon: const Icon(Icons.logout));
  }
}
