// GENERATED FILE. DO NOT EDIT

import 'package:flutter/material.dart';

abstract class DesignSystemColors {
  // Light Theme - Updated from EventCard
  static const Color background = Color(0xFFFFFFFF);
  static const Color foreground = Color(0xFF000000); // text-black
  static const Color card = Color(0xFFFFFFFF);
  static const Color cardForeground = Color(0xFF000000);
  static const Color popover = Color(0xFFFFFFFF);
  static const Color popoverForeground = Color(0xFF000000);
  static const Color primary = Color(0xFF000000); // bg-black
  static const Color primaryForeground = Color(0xFFFFFFFF); // text-white
  static const Color secondary = Color(0xFFF5F5F5); // bg-[#f5f5f5]
  static const Color secondaryForeground = Color(0xFF000000);
  static const Color muted = Color(0xFFF5F5F5); // bg-[#f5f5f5]
  static const Color mutedForeground = Color(0xFF999999); // text-[#999999]
  static const Color accent = Color(0xFFF5F5F5);
  static const Color accentForeground = Color(0xFF666666); // text-[#666666]
  static const Color destructive = Color(0xFFD4183D);
  static const Color destructiveForeground = Color(0xFFFFFFFF);
  static const Color border = Color(0xFFE5E5E5); // border-[#e5e5e5]
  static const Color input = Color(0x00000000);
  static const Color inputBackground = Color(0xFFF3F3F5);
  static const Color switchBackground = Color(0xFFCBCED4);
  static const Color ring = Color(0xFFB5B5B5);

  // Progress Colors from EventCard
  static const Color progressGreen = Color(0xFF00C950); // text-green-600
  static const Color progressBlue = Color(0xFF2B7FFF); // text-blue-600
  static const Color progressOrange = Color(0xFFFF6900); // text-orange-500

  // Chart Colors Light
  static const Color chart1 = Color(0xFFD46B08);
  static const Color chart2 = Color(0xFF08979C);
  static const Color chart3 = Color(0xFF3C5A99);
  static const Color chart4 = Color(0xFFF5A623);
  static const Color chart5 = Color(0xFFF56A00);

  // Sidebar Light
  static const Color sidebar = Color(0xFFFBFBFB);
  static const Color sidebarForeground = Color(0xFF000000);
  static const Color sidebarPrimary = Color(0xFF000000);
  static const Color sidebarPrimaryForeground = Color(0xFFFFFFFF);
  static const Color sidebarAccent = Color(0xFFF5F5F5);
  static const Color sidebarAccentForeground = Color(0xFF666666);
  static const Color sidebarBorder = Color(0xFFE5E5E5);
  static const Color sidebarRing = Color(0xFFB5B5B5);
}

abstract class DesignSystemColorsDark {
  // Dark Theme - Adjusted for dark mode equivalents
  static const Color background = Color(0xFF121212);
  static const Color foreground = Color(0xFFFFFFFF);
  static const Color card = Color(0xFF1E1E1E);
  static const Color cardForeground = Color(0xFFFFFFFF);
  static const Color popover = Color(0xFF1E1E1E);
  static const Color popoverForeground = Color(0xFFFFFFFF);
  static const Color primary = Color(0xFFFFFFFF);
  static const Color primaryForeground = Color(0xFF000000);
  static const Color secondary = Color(0xFF2A2A2A);
  static const Color secondaryForeground = Color(0xFFFFFFFF);
  static const Color muted = Color(0xFF2A2A2A);
  static const Color mutedForeground = Color(0xFFAAAAAA);
  static const Color accent = Color(0xFF2A2A2A);
  static const Color accentForeground = Color(0xFFCCCCCC);
  static const Color destructive = Color(0xFF992134);
  static const Color destructiveForeground = Color(0xFFFFFFFF);
  static const Color border = Color(0xFF333333);
  static const Color input = Color(0xFF2A2A2A);
  static const Color ring = Color(0xFF555555);

  // Progress Colors Dark
  static const Color progressGreen = Color(0xFF00E55C);
  static const Color progressBlue = Color(0xFF4A90FF);
  static const Color progressOrange = Color(0xFFFF8C42);

  // Chart Colors Dark
  static const Color chart1 = Color(0xFF4A6CD4);
  static const Color chart2 = Color(0xFF36CFC9);
  static const Color chart3 = Color(0xFFF56A00);
  static const Color chart4 = Color(0xFF9254DE);
  static const Color chart5 = Color(0xFFF75981);

  // Sidebar Dark
  static const Color sidebar = Color(0xFF1A1A1A);
  static const Color sidebarForeground = Color(0xFFFFFFFF);
  static const Color sidebarPrimary = Color(0xFFFFFFFF);
  static const Color sidebarPrimaryForeground = Color(0xFF000000);
  static const Color sidebarAccent = Color(0xFF2A2A2A);
  static const Color sidebarAccentForeground = Color(0xFFFFFFFF);
  static const Color sidebarBorder = Color(0xFF333333);
  static const Color sidebarRing = Color(0xFF555555);
}

abstract class DesignSystemTypography {
  static const double fontSizeBase = 16.0;

  // Font Weights
  static const FontWeight fontWeightNormal = FontWeight.w400;
  static const FontWeight fontWeightMedium = FontWeight.w500;
  static const FontWeight fontWeightSemibold = FontWeight.w600;

  // Text Styles based on EventCard
  static const TextStyle h1 = TextStyle(
    fontSize: 17.0, // text-[17px]
    fontWeight: fontWeightSemibold, // font-semibold
    height: 22.0 / 17.0, // leading-[22px]
  );

  static const TextStyle h2 = TextStyle(
    fontSize: 20.0,
    fontWeight: fontWeightMedium,
    height: 1.5,
  );

  static const TextStyle h3 = TextStyle(
    fontSize: 18.0,
    fontWeight: fontWeightMedium,
    height: 1.5,
  );

  static const TextStyle h4 = TextStyle(
    fontSize: 16.0,
    fontWeight: fontWeightMedium,
    height: 1.5,
  );

  static const TextStyle paragraph = TextStyle(
    fontSize: 16.0,
    fontWeight: fontWeightNormal,
    height: 1.5,
  );

  static const TextStyle label = TextStyle(
    fontSize: 16.0,
    fontWeight: fontWeightMedium,
    height: 1.5,
  );

  static const TextStyle button = TextStyle(
    fontSize: 14.0, // text-[14px]
    fontWeight: fontWeightMedium, // font-medium
    height: 1.5,
  );

  static const TextStyle input = TextStyle(
    fontSize: 16.0,
    fontWeight: fontWeightNormal,
    height: 1.5,
  );

  // Small text from EventCard
  static const TextStyle small = TextStyle(
    fontSize: 13.0, // text-[13px]
    fontWeight: fontWeightNormal,
    height: 1.5,
  );

  // Large price text from EventCard
  static const TextStyle largePrice = TextStyle(
    fontSize: 24.0, // text-[24px]
    fontWeight: fontWeightSemibold, // font-semibold
    height: 1.5,
  );
}

abstract class DesignSystemRadius {
  static const double radius = 16.0; // rounded-2xl
  static const double radiusSm = 6.0;
  static const double radiusMd = 8.0;
  static const double radiusLg = 12.0;
  static const double radiusXl = 20.0;
  static const double radiusFull = 9999.0; // rounded-full
}

// Extension for easy theme switching
extension DesignSystemTheme on BuildContext {
  bool get isDarkTheme => Theme.of(this).brightness == Brightness.dark;

  Color get background => isDarkTheme ? DesignSystemColorsDark.background : DesignSystemColors.background;
  Color get foreground => isDarkTheme ? DesignSystemColorsDark.foreground : DesignSystemColors.foreground;
  Color get primary => isDarkTheme ? DesignSystemColorsDark.primary : DesignSystemColors.primary;
  Color get border => isDarkTheme ? DesignSystemColorsDark.border : DesignSystemColors.border;
  Color get muted => isDarkTheme ? DesignSystemColorsDark.muted : DesignSystemColors.muted;
  Color get mutedForeground =>
      isDarkTheme ? DesignSystemColorsDark.mutedForeground : DesignSystemColors.mutedForeground;
  Color get secondary => isDarkTheme ? DesignSystemColorsDark.secondary : DesignSystemColors.secondary;

  // Progress colors
  Color get progressGreen => isDarkTheme ? DesignSystemColorsDark.progressGreen : DesignSystemColors.progressGreen;
  Color get progressBlue => isDarkTheme ? DesignSystemColorsDark.progressBlue : DesignSystemColors.progressBlue;
  Color get progressOrange => isDarkTheme ? DesignSystemColorsDark.progressOrange : DesignSystemColors.progressOrange;
}
