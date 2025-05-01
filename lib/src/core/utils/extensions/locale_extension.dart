import 'dart:ui';

extension LocaleX on Locale {
  String get label => switch (languageCode) {
    'en' => 'English',
    'ru' => 'Русский',
    _ => throw AssertionError('Unsupported language code: $languageCode'),
  };
}
