import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

abstract interface class ILocaleDataProvider {
  Future<Locale?> getLocale();

  Future<void> setLocale(Locale locale);
}

final class LocaleDataProvider implements ILocaleDataProvider {
  const LocaleDataProvider({required SharedPreferencesAsync sharedPreferences})
    : _sharedPreferences = sharedPreferences;

  final SharedPreferencesAsync _sharedPreferences;

  static const String _localKey = 'locale';

  @override
  Future<Locale?> getLocale() async {
    final languageCode = await _sharedPreferences.getString(_localKey);
    if (languageCode == null) return null;

    return Locale(languageCode);
  }

  @override
  Future<void> setLocale(Locale locale) => _sharedPreferences.setString(_localKey, locale.languageCode);
}
