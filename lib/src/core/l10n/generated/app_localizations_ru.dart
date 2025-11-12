// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get settings => 'Настройки';

  @override
  String get themeModeTitle => 'Тема';

  @override
  String get themeModeSystem => 'Как на устройстве';

  @override
  String get themeModeLight => 'Светлая';

  @override
  String get themeModeDark => 'Темная';

  @override
  String get localeTitle => 'Язык приложения';
}
