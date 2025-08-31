import 'package:flutter/material.dart';
import 'package:vm_app/src/core/ui-kit/button.dart';
import 'package:vm_app/src/core/widget/safe_scaffold.dart';
import 'package:vm_app/src/feature/auth/widget/authentication_scope.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeScaffold(
      appBar: AppBar(title: const Text('Профиль')),
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
