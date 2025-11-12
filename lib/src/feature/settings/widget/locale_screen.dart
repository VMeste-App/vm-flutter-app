import 'package:flutter/material.dart';
import 'package:vm_app/src/core/l10n/app_localization.dart';
import 'package:vm_app/src/core/ui-kit/picker_group.dart';
import 'package:vm_app/src/core/utils/extensions/context_extension.dart';
import 'package:vm_app/src/core/utils/extensions/locale_extension.dart';
import 'package:vm_app/src/core/widget/safe_scaffold.dart';
import 'package:vm_app/src/feature/settings/widget/settings_scope.dart';

class LocaleScreen extends StatelessWidget {
  const LocaleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = SettingsScope.localeOf(context);

    return SafeScaffold(
      appBar: AppBar(title: Text(context.l10n.localeTitle)),
      body: VmPickerGroup(
        selected: locale,
        items: AppLocalization.supportedLocales.map((e) => PickerItem(id: e, title: e.label)).toList(),
        onSelected: (locale) => SettingsScope.setLocale(context, locale as Locale),
      ),
    );
  }
}
