// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get settings => 'Settings';

  @override
  String get themeModeTitle => 'Appearance';

  @override
  String get themeModeSystem => 'Use device theme';

  @override
  String get themeModeLight => 'Light theme';

  @override
  String get themeModeDark => 'Dark theme';

  @override
  String get localeTitle => 'App Language';

  @override
  String level(String level) {
    String _temp0 = intl.Intl.selectLogic(
      level,
      {
        'beginner': 'Beginner',
        'intermediate': 'Intermediate',
        'advanced': 'Advanced',
        'pro': 'Professional',
        'other': 'Unknown',
      },
    );
    return '$_temp0';
  }

  @override
  String participantCategory(String participantCategory) {
    String _temp0 = intl.Intl.selectLogic(
      participantCategory,
      {
        'male': 'Male',
        'female': 'Female',
        'mixed': 'Mixed',
        'other': 'Unknown',
      },
    );
    return '$_temp0';
  }
}
