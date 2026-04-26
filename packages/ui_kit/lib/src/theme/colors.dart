import 'package:flutter/material.dart';

@immutable
final class VmThemeColors {
  const VmThemeColors({
    required this.background,
    required this.surface,
    required this.surfaceHigh,
    required this.surfaceHighest,
    required this.border,
    required this.borderStrong,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.textDisabled,
    required this.primary,
    required this.primaryPressed,
    required this.primaryMuted,
    required this.onPrimary,
    required this.success,
    required this.successMuted,
    required this.danger,
    required this.dangerMuted,
    required this.warning,
    required this.accent,
    required this.accentMuted,
    required this.scrim,
    required this.transparent,
  });

  static const light = VmThemeColors(
    background: Color(0xFFFFFFFF),
    surface: Color(0xFFFFFFFF),
    surfaceHigh: Color(0xFFF2F5F9),
    surfaceHighest: Color(0xFFEAF0F6),
    border: Color(0xFFDDE5EE),
    borderStrong: Color(0xFFC8D3DE),
    textPrimary: Color(0xFF000000),
    textSecondary: Color(0xFF80909E),
    textTertiary: Color(0xFFB8C2CC),
    textDisabled: Color(0xFFD5DDE5),
    primary: Color(0xFF0A7DFF),
    primaryPressed: Color(0xFF006BDF),
    primaryMuted: Color(0xFFE5F4FF),
    onPrimary: Color(0xFFFFFFFF),
    success: Color(0xFF16C866),
    successMuted: Color(0xFFE7F8EE),
    danger: Color(0xFFFF4D43),
    dangerMuted: Color(0xFFFFECEA),
    warning: Color(0xFFFFA000),
    accent: Color(0xFF8B4DFF),
    accentMuted: Color(0xFFF3ECFF),
    scrim: Color(0x66000000),
    transparent: Color(0x00000000),
  );

  static const dark = VmThemeColors(
    background: Color(0xFF000000),
    surface: Color(0xFF1C1C1E),
    surfaceHigh: Color(0xFF2C2C2E),
    surfaceHighest: Color(0xFF3A3A3C),
    border: Color(0xFF303033),
    borderStrong: Color(0xFF3F3F42),
    textPrimary: Color(0xFFFFFFFF),
    textSecondary: Color(0xFFB8B8BC),
    textTertiary: Color(0xFF7A7A80),
    textDisabled: Color(0xFF56565C),
    primary: Color(0xFF2F80ED),
    primaryPressed: Color(0xFF1F6FD6),
    primaryMuted: Color(0xFF1F3044),
    onPrimary: Color(0xFFFFFFFF),
    success: Color(0xFF16C866),
    successMuted: Color(0xFF123D24),
    danger: Color(0xFFFF4D43),
    dangerMuted: Color(0xFF421B18),
    warning: Color(0xFFFFA000),
    accent: Color(0xFFA679FF),
    accentMuted: Color(0xFF2F2147),
    scrim: Color(0xCC000000),
    transparent: Color(0x00000000),
  );

  final Color background;
  final Color surface;
  final Color surfaceHigh;
  final Color surfaceHighest;
  final Color border;
  final Color borderStrong;
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color textDisabled;
  final Color primary;
  final Color primaryPressed;
  final Color primaryMuted;
  final Color onPrimary;
  final Color success;
  final Color successMuted;
  final Color danger;
  final Color dangerMuted;
  final Color warning;
  final Color accent;
  final Color accentMuted;
  final Color scrim;
  final Color transparent;

  static VmThemeColors byBrightness(Brightness brightness) {
    return brightness == Brightness.dark ? dark : light;
  }

  static VmThemeColors of(BuildContext context) {
    return byBrightness(Theme.of(context).brightness);
  }
}
