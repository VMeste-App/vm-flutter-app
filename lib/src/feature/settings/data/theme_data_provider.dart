import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vm_app/src/feature/settings/data/theme_mode_codec.dart';

abstract interface class IThemeDataProvider {
  Future<void> setThemeMode(ThemeMode mode);

  Future<ThemeMode?> getThemeMode();
}

final class ThemeDataProvider implements IThemeDataProvider {
  const ThemeDataProvider({required SharedPreferences sharedPreferences}) : _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;

  static const String _themeModeKey = 'theme_mode';

  /// Coder/decoder for [ThemeMode].
  static const themeCodec = ThemeModeCodec();

  @override
  Future<ThemeMode?> getThemeMode() async {
    final themeModeValue = _sharedPreferences.getString(_themeModeKey);

    return themeModeValue != null ? themeCodec.decode(themeModeValue) : null;
  }

  @override
  Future<bool> setThemeMode(ThemeMode mode) => _sharedPreferences.setString(_themeModeKey, themeCodec.encode(mode));
}
