import 'package:flutter/material.dart';
import 'package:vm_app/src/core/navigator/navigator.dart';
import 'package:vm_app/src/core/navigator/pages.dart';
import 'package:vm_app/src/core/ui-kit/avatar.dart';
import 'package:vm_app/src/core/ui-kit/scaffold.dart';
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
              leading: const Icon(Icons.person_2_rounded),
              onTap: () => VmNavigator.push(context, const ProfilePage()),
              title: const Text('Мой профиль'),
            ),
            ListTile(
              enabled: false,
              leading: const Icon(Icons.notifications_none_outlined),
              onTap: () => VmNavigator.push(context, const ProfilePage()),
              title: const Text('Уведомления'),
            ),
            ListTile(
              enabled: false,
              leading: const Icon(Icons.star_border_outlined),
              onTap: () => VmNavigator.push(context, const ProfilePage()),
              title: const Text('Отзывы'),
            ),
            // ListTile(
            //   leading: const Icon(Icons.app_registration_outlined),
            //   onTap: () => VmNavigator.push(context, const ProfilePage()),
            //   title: const Text('Оформление'),
            // ),
            // ListTile(
            //   leading: const Icon(Icons.language_outlined),
            //   onTap: () => VmNavigator.push(context, const ProfilePage()),
            //   title: const Text('Язык'),
            // ),
            ListTile(
              leading: const Icon(Icons.info_outline_rounded),
              onTap: () => VmNavigator.push(context, const ProfilePage()),
              title: const Text('О приложении'),
            ),
          ],
        ),
      ),
    );
  }
}
