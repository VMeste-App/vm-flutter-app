import 'package:flutter/material.dart';
import 'package:vm_app/src/feature/settings/data/theme_data_provider.dart';

abstract interface class IThemeRepository {
  Future<void> setThemeMode(ThemeMode mode);

  Future<ThemeMode?> getThemeMode();
}

final class ThemeRepository implements IThemeRepository {
  const ThemeRepository({required IThemeDataProvider dataProvider}) : _dataProvider = dataProvider;

  final IThemeDataProvider _dataProvider;

  @override
  Future<ThemeMode?> getThemeMode() => _dataProvider.getThemeMode();

  @override
  Future<void> setThemeMode(ThemeMode mode) => _dataProvider.setThemeMode(mode);
}
