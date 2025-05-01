import 'dart:ui';

import 'package:vm_app/src/feature/settings/data/locale_data_provider.dart';

abstract interface class ILocaleRepository {
  Future<Locale?> getLocale();

  Future<void> setLocale(Locale locale);
}

final class LocaleRepository implements ILocaleRepository {
  const LocaleRepository({required ILocaleDataProvider dataProvider}) : _dataProvider = dataProvider;

  final ILocaleDataProvider _dataProvider;

  @override
  Future<Locale?> getLocale() => _dataProvider.getLocale();

  @override
  Future<void> setLocale(Locale locale) => _dataProvider.setLocale(locale);
}
