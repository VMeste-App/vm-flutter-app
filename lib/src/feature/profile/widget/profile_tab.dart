import 'package:flutter/material.dart';
import 'package:vm_app/src/core/navigator/navigator.dart';
import 'package:vm_app/src/core/navigator/pages.dart';
import 'package:vm_app/src/core/ui-kit/avatar.dart';
import 'package:vm_app/src/core/ui-kit/button.dart';
import 'package:vm_app/src/core/ui-kit/scaffold.dart';
import 'package:vm_app/src/feature/auth/widget/authentication_scope.dart';
import 'package:vm_app/src/feature/settings/widget/settings_screen.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return VmScaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_rounded),
            onPressed: () => VmNavigator.push(context, const VmPage(fullscreenDialog: true, child: SettingsScreen())),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const VmAvatar.large(),
            const SizedBox(height: 16.0),
            const Text(
              'Иванов Иван',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 48.0),
            ListTile(
              onTap: () => VmNavigator.push(context, const ProfilePage()),
              title: const Text('Мой профиль'),
            ),
            const SizedBox(
              height: 300,
            ),
            VmButton(
              onPressed: () => AuthenticationScope.signOut(context),
              child: const Text('Выйти'),
            ),
          ],
        ),
      ),
    );
  }
}
