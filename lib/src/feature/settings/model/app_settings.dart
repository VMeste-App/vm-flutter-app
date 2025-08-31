import 'package:flutter/material.dart';
import 'package:vm_app/src/core/l10n/app_localization.dart';

@immutable
final class AppSettings {
  AppSettings({ThemeMode? themeMode, Locale? locale})
    : themeMode = themeMode ?? ThemeMode.system,
      locale = locale ?? AppLocalization.defaultLocale;

  final ThemeMode themeMode;
  final Locale locale;

  AppSettings copyWith({
    ThemeMode? themeMode,
    Locale? locale,
  }) => AppSettings(
    themeMode: themeMode ?? this.themeMode,
    locale: locale ?? this.locale,
  );

  @override
  String toString() => 'AppSettings(themeMode: $themeMode, locale: $locale)';

  @override
  bool operator ==(covariant AppSettings other) =>
      identical(this, other) ||
      runtimeType == other.runtimeType && themeMode == other.themeMode && locale == other.locale;

  @override
  int get hashCode => Object.hash(themeMode, locale);
}
