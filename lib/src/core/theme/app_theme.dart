import 'package:flutter/material.dart';

@immutable
final class AppTheme {
  AppTheme({ThemeMode? mode, Color? seedColor})
    : mode = mode ?? ThemeMode.system,
      seedColor = seedColor ?? _defaultSeedColor,
      darkTheme = ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: seedColor ?? _defaultSeedColor, brightness: Brightness.dark),
      ),
      lightTheme = ThemeData.light().copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: seedColor ?? _defaultSeedColor),
      );

  /// The type of theme to use.
  final ThemeMode mode;

  /// The seed color to generate the [ColorScheme] from.
  final Color seedColor;

  /// The dark [ThemeData] for this [AppTheme].
  final ThemeData darkTheme;

  /// The light [ThemeData] for this [AppTheme].
  final ThemeData lightTheme;

  static const Color _defaultSeedColor = Color(0xFF6750A4);

  AppTheme copyWith({ThemeMode? mode, Color? seedColor}) =>
      AppTheme(mode: mode ?? this.mode, seedColor: seedColor ?? this.seedColor);

  @override
  String toString() => 'AppTheme(themeMode: $mode, seedColor: $seedColor)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppTheme && runtimeType == other.runtimeType && mode == other.mode && seedColor == other.seedColor;

  @override
  int get hashCode => Object.hash(mode, seedColor);
}
