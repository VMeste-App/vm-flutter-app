import 'package:flutter/material.dart';
import 'package:vm_app/src/core/l10n/app_localization.dart';
import 'package:vm_app/src/core/theme/app_theme.dart';

@immutable
final class AppSettings {
  AppSettings({AppTheme? theme, Locale? locale})
    : theme = theme ?? AppTheme(),
      locale = locale ?? AppLocalization.defaultLocale;

  final AppTheme theme;
  final Locale locale;

  AppSettings copyWith({AppTheme? theme, Locale? locale}) =>
      AppSettings(theme: theme ?? this.theme, locale: locale ?? this.locale);

  @override
  String toString() => 'AppSettings(theme: $theme, locale: $locale)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppSettings && runtimeType == other.runtimeType && theme == other.theme && locale == other.locale;

  @override
  int get hashCode => Object.hash(theme, locale);
}
