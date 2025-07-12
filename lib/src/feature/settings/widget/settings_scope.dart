import 'package:control/control.dart';
import 'package:flutter/material.dart';
import 'package:vm_app/src/core/theme/app_theme.dart';
import 'package:vm_app/src/feature/settings/controller/settings_controller.dart';

class SettingsScope extends StatefulWidget {
  const SettingsScope({super.key, required this.controller, required this.child});

  final SettingsController controller;
  final Widget child;

  /// Get the [SettingsScopeController] of the closest [SettingsScope] ancestor.
  static SettingsScopeController of(BuildContext context) =>
      context.getInheritedWidgetOfExactType<_InheritedSettingsScope>()!.controller;

  /// Get the [ThemeScopeController] of the closest [SettingsScope] ancestor.
  static ThemeScopeController themeOf(BuildContext context) =>
      InheritedModel.inheritFrom<_InheritedSettingsScope>(context, aspect: _SettingsScopeAspect.theme)!.controller;

  /// Get the [LocaleScopeController] of the closest [SettingsScope] ancestor.
  static LocaleScopeController localeOf(BuildContext context) =>
      InheritedModel.inheritFrom<_InheritedSettingsScope>(context, aspect: _SettingsScopeAspect.locale)!.controller;

  @override
  State<SettingsScope> createState() => _SettingsScopeState();
}

class _SettingsScopeState extends State<SettingsScope> implements SettingsScopeController {
  @override
  Widget build(BuildContext context) {
    return StateConsumer<SettingsController, SettingsState>(
      controller: widget.controller,
      buildWhen: (previous, current) => previous.settings != current.settings,
      builder: (context, state, child) {
        return _InheritedSettingsScope(state: state, controller: this, child: widget.child);
      },
    );
  }

  @override
  AppTheme get theme => widget.controller.state.settings.theme;

  @override
  Locale get locale => widget.controller.state.settings.locale;

  @override
  void setLocale(Locale locale) => widget.controller.setLocale(locale);

  @override
  void setThemeMode(ThemeMode themeMode) => widget.controller.setThemeMode(themeMode);
}

class _InheritedSettingsScope extends InheritedModel<_SettingsScopeAspect> {
  const _InheritedSettingsScope({required this.state, required this.controller, required super.child});

  final SettingsState state;
  final SettingsScopeController controller;

  @override
  bool updateShouldNotify(covariant _InheritedSettingsScope oldWidget) => oldWidget.state != state;

  @override
  bool updateShouldNotifyDependent(
    covariant _InheritedSettingsScope oldWidget,
    Set<_SettingsScopeAspect> dependencies,
  ) {
    var shouldNotify = false;

    if (dependencies.contains(_SettingsScopeAspect.theme)) {
      shouldNotify = shouldNotify || state.settings.theme != oldWidget.state.settings.theme;
    }

    if (dependencies.contains(_SettingsScopeAspect.locale)) {
      shouldNotify = shouldNotify || state.settings.locale != oldWidget.state.settings.locale;
    }

    return shouldNotify;
  }
}

abstract interface class ThemeScopeController {
  /// Get the current [AppTheme].
  AppTheme get theme;

  /// Set the theme mode to [themeMode].
  void setThemeMode(ThemeMode themeMode);
}

abstract interface class LocaleScopeController {
  /// Get the current [Locale]
  Locale get locale;

  /// Set locale to [locale].
  void setLocale(Locale locale);
}

abstract interface class SettingsScopeController implements ThemeScopeController, LocaleScopeController {}

enum _SettingsScopeAspect {
  /// The theme aspect.
  theme,

  /// The locale aspect.
  locale,
}
