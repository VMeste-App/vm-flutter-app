import 'package:flutter/material.dart';
import 'package:vm_app/src/core/theme/app_theme.dart';
import 'package:vm_app/src/feature/settings/data/theme_data_provider.dart';

abstract interface class IThemeRepository {
  Future<void> setThemeMode(ThemeMode mode);

  Future<AppTheme?> getTheme();
}

final class ThemeRepository implements IThemeRepository {
  const ThemeRepository({required IThemeDataProvider dataProvider}) : _dataProvider = dataProvider;

  final IThemeDataProvider _dataProvider;

  @override
  Future<AppTheme?> getTheme() => _dataProvider.getTheme();

  @override
  Future<void> setThemeMode(ThemeMode mode) => _dataProvider.setThemeMode(mode);
}
