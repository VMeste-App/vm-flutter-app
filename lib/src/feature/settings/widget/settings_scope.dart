import 'package:control/control.dart';
import 'package:flutter/material.dart';
import 'package:vm_app/src/feature/settings/controller/settings_controller.dart';

class SettingsScope extends StatefulWidget {
  const SettingsScope({
    super.key,
    required this.controller,
    required this.child,
  });

  final SettingsController controller;
  final Widget child;

  /// Get the current theme mode.
  static ThemeMode themeModeOf(BuildContext context) => _InheritedSettingsScope.themeModeOf(context);

  /// Set the theme mode.
  static void setThemeMode(BuildContext context, ThemeMode themeMode) => _controllerOf(context).setThemeMode(themeMode);

  /// Get the current locale.
  static Locale localeOf(BuildContext context) => _InheritedSettingsScope.localeOf(context);

  /// Set the locale.
  static void setLocale(BuildContext context, Locale locale) => _controllerOf(context).setLocale(locale);

  /// Get the [SettingsScopeController] of the closest [SettingsScope] ancestor.
  static SettingsScopeController _controllerOf(BuildContext context) => _InheritedSettingsScope.controllerOf(context);

  @override
  State<SettingsScope> createState() => _SettingsScopeState();
}

class _SettingsScopeState extends State<SettingsScope> implements SettingsScopeController {
  @override
  Widget build(BuildContext context) {
    return StateConsumer<SettingsController, SettingsState>(
      controller: widget.controller,
      buildWhen: (previous, current) => previous.settings != current.settings,
      builder: (context, state, child) => _InheritedSettingsScope(
        state: state,
        controller: this,
        child: widget.child,
      ),
    );
  }

  @override
  ThemeMode get themeMode => widget.controller.state.settings.themeMode;

  @override
  Locale get locale => widget.controller.state.settings.locale;

  @override
  void setLocale(Locale locale) => widget.controller.setLocale(locale);

  @override
  void setThemeMode(ThemeMode themeMode) => widget.controller.setThemeMode(themeMode);
}

class _InheritedSettingsScope extends InheritedModel<_SettingsScopeAspect> {
  const _InheritedSettingsScope({
    required this.state,
    required this.controller,
    required super.child,
  });

  final SettingsState state;
  final SettingsScopeController controller;

  static SettingsScopeController controllerOf(BuildContext context) =>
      context.getInheritedWidgetOfExactType<_InheritedSettingsScope>()!.controller;

  static ThemeMode themeModeOf(BuildContext context) => InheritedModel.inheritFrom<_InheritedSettingsScope>(
    context,
    aspect: _SettingsScopeAspect.theme,
  )!.state.settings.themeMode;

  static Locale localeOf(BuildContext context) => InheritedModel.inheritFrom<_InheritedSettingsScope>(
    context,
    aspect: _SettingsScopeAspect.locale,
  )!.state.settings.locale;

  @override
  bool updateShouldNotify(covariant _InheritedSettingsScope oldWidget) => oldWidget.state.settings != state.settings;

  @override
  bool updateShouldNotifyDependent(
    covariant _InheritedSettingsScope oldWidget,
    Set<_SettingsScopeAspect> dependencies,
  ) {
    var shouldNotify = false;

    if (dependencies.contains(_SettingsScopeAspect.theme)) {
      shouldNotify = shouldNotify || state.settings.themeMode != oldWidget.state.settings.themeMode;
    }

    if (dependencies.contains(_SettingsScopeAspect.locale)) {
      shouldNotify = shouldNotify || state.settings.locale != oldWidget.state.settings.locale;
    }

    return shouldNotify;
  }
}

abstract interface class ThemeScopeController {
  /// Get the current theme mode.
  ThemeMode get themeMode;

  /// Set the theme mode.
  void setThemeMode(ThemeMode themeMode);
}

abstract interface class LocaleScopeController {
  /// Get the current locale.
  Locale get locale;

  /// Set locale.
  void setLocale(Locale locale);
}

abstract interface class SettingsScopeController implements ThemeScopeController, LocaleScopeController {}

enum _SettingsScopeAspect {
  /// The theme aspect.
  theme,

  /// The locale aspect.
  locale,
}
