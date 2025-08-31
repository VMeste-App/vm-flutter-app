import 'package:flutter/material.dart';
import 'package:vm_app/src/core/navigator/navigator.dart';
import 'package:vm_app/src/core/navigator/pages.dart';
import 'package:vm_app/src/core/ui-kit/button.dart';
import 'package:vm_app/src/core/widget/safe_scaffold.dart';
import 'package:vm_app/src/feature/auth/widget/authentication_scope.dart';
import 'package:vm_app/src/feature/settings/widget/settings_screen.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeScaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_rounded),
            onPressed: () => VmNavigator.push(context, const VmPage(fullscreenDialog: true, child: SettingsScreen())),
          ),
        ],
      ),
      body: Column(
        children: [
          VmButton(
            onPressed: () => AuthenticationScope.signOut(context),
            child: const Text('Выйти'),
          ),
        ],
      ),
    );
  }
}
