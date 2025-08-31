import 'package:flutter/material.dart';
import 'package:vm_app/src/core/ui-kit/picker_group.dart';
import 'package:vm_app/src/core/utils/extensions/context_extension.dart';
import 'package:vm_app/src/core/widget/safe_scaffold.dart';
import 'package:vm_app/src/feature/settings/widget/settings_scope.dart';

class ThemeModeScreen extends StatelessWidget {
  const ThemeModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = SettingsScope.themeModeOf(context);

    return SafeScaffold(
      appBar: AppBar(title: Text(context.l10n.themeModeTitle)),
      body: VmPickerGroup(
        selected: theme,
        items: ThemeMode.values.map((e) => PickerItem(id: e, title: e.localize(context))).toList(),
        onSelected: (mode) => SettingsScope.setThemeMode(context, mode as ThemeMode),
      ),
    );
  }
}

extension ThemeModeX on ThemeMode {
  String localize(BuildContext context) => switch (this) {
    ThemeMode.system => context.l10n.themeModeSystem,
    ThemeMode.light => context.l10n.themeModeLight,
    ThemeMode.dark => context.l10n.themeModeDark,
  };
}
