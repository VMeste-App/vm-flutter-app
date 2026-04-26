import 'package:flutter/material.dart';
import 'package:ui_kit/src/theme/colors.dart';
import 'package:ui_kit/src/theme/typography.dart';

@immutable
final class VmTheme {
  VmTheme({ThemeMode? mode})
    : mode = mode ?? ThemeMode.system,
      darkTheme = _themeData(Brightness.dark),
      lightTheme = _themeData(Brightness.light);

  final ThemeMode mode;
  final ThemeData darkTheme;
  final ThemeData lightTheme;

  VmTheme copyWith({ThemeMode? mode, Color? seedColor}) => VmTheme(mode: mode ?? this.mode);
}

ThemeData _themeData(Brightness brightness) {
  final colors = VmThemeColors.byBrightness(brightness);
  final isDark = brightness == Brightness.dark;
  final base = isDark ? ThemeData.dark() : ThemeData.light();

  return base.copyWith(
    brightness: brightness,
    splashFactory: NoSplash.splashFactory,
    textTheme: _textTheme(colors),
    primaryColor: colors.primary,
    colorScheme: ColorScheme(
      brightness: brightness,
      primary: colors.primary,
      onPrimary: colors.onPrimary,
      secondary: colors.surfaceHigh,
      onSecondary: colors.textPrimary,
      error: colors.danger,
      onError: colors.onPrimary,
      surface: colors.surface,
      onSurface: colors.textPrimary,
    ),
    inputDecorationTheme: _inputDecorationTheme(colors),
    scaffoldBackgroundColor: colors.background,
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        minimumSize: WidgetStateProperty.all(const Size.fromHeight(52.0)),
        fixedSize: WidgetStateProperty.all(const Size.fromHeight(52.0)),
        shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0))),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: colors.background,
      foregroundColor: colors.textPrimary,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: colors.transparent,
      shadowColor: colors.transparent,
      titleTextStyle: VmTextStyles.titleLarge.copyWith(color: colors.textPrimary),
    ),
    switchTheme: SwitchThemeData(
      trackOutlineColor: WidgetStateProperty.all(colors.transparent),
      trackColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.selected)) {
          return colors.primary;
        }

        return colors.surfaceHighest;
      }),
      thumbColor: WidgetStateProperty.all(colors.onPrimary),
      overlayColor: WidgetStateProperty.all(colors.transparent),
    ),
    dividerTheme: DividerThemeData(color: colors.border),
    listTileTheme: ListTileThemeData(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      iconColor: colors.textPrimary,
      titleTextStyle: VmTextStyles.bodyLarge.copyWith(color: colors.textPrimary),
      subtitleTextStyle: VmTextStyles.bodySmall.copyWith(color: colors.textSecondary),
    ),
    navigationBarTheme: _navigationBarTheme(colors),
    tabBarTheme: _tabBarTheme(colors, isDark),
  );
}

TextTheme _textTheme(VmThemeColors colors) {
  return TextTheme(
    displayLarge: VmTextStyles.displayLarge.copyWith(color: colors.textPrimary),
    displayMedium: VmTextStyles.displayMedium.copyWith(color: colors.textPrimary),
    displaySmall: VmTextStyles.displaySmall.copyWith(color: colors.textPrimary),
    headlineLarge: VmTextStyles.headlineLarge.copyWith(color: colors.textPrimary),
    headlineMedium: VmTextStyles.headlineMedium.copyWith(color: colors.textPrimary),
    headlineSmall: VmTextStyles.headlineSmall.copyWith(color: colors.textPrimary),
    titleLarge: VmTextStyles.titleLarge.copyWith(color: colors.textPrimary),
    titleMedium: VmTextStyles.titleMedium.copyWith(color: colors.textPrimary),
    titleSmall: VmTextStyles.titleSmall.copyWith(color: colors.textPrimary),
    bodyLarge: VmTextStyles.bodyLarge.copyWith(color: colors.textPrimary),
    bodyMedium: VmTextStyles.bodyMedium.copyWith(color: colors.textPrimary),
    bodySmall: VmTextStyles.bodySmall.copyWith(color: colors.textSecondary),
    labelLarge: VmTextStyles.labelLarge.copyWith(color: colors.textPrimary),
    labelMedium: VmTextStyles.labelMedium.copyWith(color: colors.textPrimary),
    labelSmall: VmTextStyles.labelSmall.copyWith(color: colors.textSecondary),
  );
}

NavigationBarThemeData _navigationBarTheme(VmThemeColors colors) {
  return NavigationBarThemeData(
    backgroundColor: colors.surface,
    indicatorColor: colors.transparent,
    elevation: 0.0,
    iconTheme: WidgetStateProperty.fromMap({
      WidgetState.selected: IconThemeData(color: colors.textPrimary, size: 30.0),
      WidgetState.any: IconThemeData(color: colors.textSecondary, size: 30.0),
    }),
    labelTextStyle: WidgetStateProperty.fromMap({
      WidgetState.selected: VmTextStyles.tabLabel.copyWith(color: colors.textPrimary),
      WidgetState.any: VmTextStyles.tabLabel.copyWith(color: colors.textSecondary),
    }),
  );
}

TabBarThemeData _tabBarTheme(VmThemeColors colors, bool isDark) {
  return TabBarThemeData(
    labelColor: isDark ? colors.background : colors.surface,
    unselectedLabelColor: colors.textSecondary,
    dividerColor: colors.transparent,
    overlayColor: WidgetStateProperty.all(colors.transparent),
    labelStyle: VmTextStyles.labelLarge,
    unselectedLabelStyle: VmTextStyles.labelLarge,
    indicator: BoxDecoration(
      color: colors.textPrimary,
      borderRadius: BorderRadius.circular(999.0),
    ),
    indicatorSize: TabBarIndicatorSize.tab,
  );
}

InputDecorationTheme _inputDecorationTheme(VmThemeColors colors) {
  final border = OutlineInputBorder(borderRadius: BorderRadius.circular(18.0));

  return InputDecorationTheme(
    isDense: true,
    filled: true,
    fillColor: colors.background,
    border: border,
    enabledBorder: border.copyWith(borderSide: BorderSide(color: colors.borderStrong)),
    focusedBorder: border.copyWith(borderSide: BorderSide(color: colors.textSecondary)),
    errorBorder: border.copyWith(borderSide: BorderSide(color: colors.danger)),
    errorStyle: TextStyle(color: colors.danger),
    contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
    hintStyle: WidgetStateTextStyle.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return TextStyle(color: colors.textDisabled);
      }

      return TextStyle(color: colors.textTertiary);
    }),
    helperStyle: TextStyle(color: colors.textSecondary),
    disabledBorder: border.copyWith(borderSide: BorderSide(color: colors.textDisabled)),
    prefixIconColor: colors.textSecondary,
    suffixIconColor: colors.textSecondary,
  );
}
