import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vm_app/src/core/navigator/navigator.dart';
import 'package:vm_app/src/core/navigator/pages.dart';
import 'package:vm_app/src/core/ui-kit/avatar.dart';
import 'package:vm_app/src/core/ui-kit/button.dart';
import 'package:vm_app/src/core/ui-kit/scaffold.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VmScaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.mode_edit_outline_outlined),
            onPressed: () => VmNavigator.push(context, const ProfileEditPage()),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                ImagePicker().pickImage(
                  source: ImageSource.gallery,
                  requestFullMetadata: false,
                );
              },
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  const VmAvatar.large(),

                  // Слой затемнения — нужно знать размер аватарки
                  Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(50),
                      shape: BoxShape.circle, // если аватарка круглая
                    ),
                  ),
                  const Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Иванов Иван',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {},
              child: const Text('Удалить аккаунт'),
            ),
            const SizedBox(height: 8.0),
            VmButton(
              onPressed: () {},
              child: const Text('Выйти'),
            ),
          ],
        ),
      ),
    );
  }
}
