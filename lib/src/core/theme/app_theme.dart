import 'package:flutter/material.dart';

@immutable
final class AppTheme {
  AppTheme({ThemeMode? mode, Color? seedColor})
    : mode = mode ?? ThemeMode.system,
      seedColor = seedColor ?? _defaultSeedColor,
      darkTheme = ThemeData.dark().copyWith(
        colorScheme: const ColorScheme.dark(),
        inputDecorationTheme: _inputDecorationTheme,
      ),
      lightTheme = ThemeData.light().copyWith(
        primaryColor: Colors.black,
        colorScheme: const ColorScheme.light(primary: Colors.black),
        inputDecorationTheme: _inputDecorationTheme,
        filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyle(
            minimumSize: WidgetStateProperty.all(const Size.fromHeight(40.0)),
            fixedSize: WidgetStateProperty.all(const Size.fromHeight(40.0)),
            shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0))),
            splashFactory: NoSplash.splashFactory,
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.transparent,
          titleTextStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        switchTheme: SwitchThemeData(
          trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
          trackColor: WidgetStateProperty.resolveWith<Color?>((states) {
            if (states.contains(WidgetState.selected)) {
              return Colors.black; // включено
            }
            return Colors.grey.shade300; // выключено
          }),
          thumbColor: WidgetStateProperty.all(Colors.white),
          overlayColor: WidgetStateProperty.all(Colors.transparent),
        ),
        dividerTheme: DividerThemeData(color: Colors.grey.shade200),
        listTileTheme: const ListTileThemeData(
          contentPadding: EdgeInsets.only(left: 16.0, right: 8.0),
          titleTextStyle: TextStyle(fontSize: 14.0, color: Colors.black),
        ),
      );

  /// The type of theme to use.
  final ThemeMode mode;

  /// The seed color to generate the [ColorScheme] from.
  final Color seedColor;

  /// The dark [ThemeData] for this [AppTheme].
  final ThemeData darkTheme;

  /// The light [ThemeData] for this [AppTheme].
  final ThemeData lightTheme;

  static const Color _defaultSeedColor = Colors.red;

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

final _border = OutlineInputBorder(borderRadius: BorderRadius.circular(8.0));

final _inputDecorationTheme = InputDecorationTheme(
  isDense: true,
  border: _border,
  enabledBorder: _border.copyWith(borderSide: BorderSide(color: Colors.grey.withValues(alpha: 0.5))),
  focusedBorder: _border,
  contentPadding: const EdgeInsets.all(14.0),
  hintStyle: WidgetStateTextStyle.resolveWith((states) {
    if (states.contains(WidgetState.disabled)) {
      return TextStyle(color: Colors.grey.withValues(alpha: 0.2));
    }

    return TextStyle(color: Colors.grey.withValues(alpha: 0.5));
  }),
  disabledBorder: _border.copyWith(borderSide: BorderSide(color: Colors.grey.withValues(alpha: 0.2))),
  prefixIconColor: Colors.grey.withValues(alpha: 0.5),
);
