import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vm_app/src/core/navigator/navigator.dart';
import 'package:vm_app/src/core/navigator/pages.dart';
import 'package:vm_app/src/core/ui-kit/avatar.dart';
import 'package:vm_app/src/core/ui-kit/scaffold.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

/// State for widget ProfileScreen.
class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    // Initial state initialization
  }

  @override
  void dispose() {
    // Permanent removal of a tree stent
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VmScaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => VmNavigator.push(context, const ProfileEditPage()),
          ),
        ],
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              ImagePicker().pickImage(
                source: ImageSource.gallery,
                requestFullMetadata: false,
              );
            },
            child: const VmAvatar.large(),
          ),
          const SizedBox(height: 16.0),
          const Text(
            'Иванов Иван',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
