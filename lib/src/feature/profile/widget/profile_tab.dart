import 'package:control/control.dart';
import 'package:flutter/material.dart';
import 'package:vm_app/src/core/di/dependencies.dart';
import 'package:vm_app/src/core/navigator/navigator.dart';
import 'package:vm_app/src/core/navigator/pages.dart';
import 'package:vm_app/src/core/ui-kit/avatar.dart';
import 'package:vm_app/src/core/ui-kit/button.dart';
import 'package:vm_app/src/core/ui-kit/loader.dart';
import 'package:vm_app/src/core/ui-kit/scaffold.dart';
import 'package:vm_app/src/feature/auth/widget/authentication_scope.dart';
import 'package:vm_app/src/feature/profile/controller/profile_controller.dart';
import 'package:vm_app/src/feature/profile/controller/profile_state.dart';
import 'package:vm_app/src/feature/profile/model/profile.dart';
import 'package:vm_app/src/feature/profile/widget/avatar_preview_screen.dart';
import 'package:vm_app/src/feature/settings/widget/settings_screen.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  ProfileController? _controller;
  ProfileId? _profileId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final userId = AuthenticationScope.userIdOf(context);
    if (userId == null || userId == _profileId) return;

    _controller?.dispose();
    _profileId = userId;
    _controller = ProfileController(
      id: userId,
      repository: Dependencies.of(context).profileRepository,
    )..fetch();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;

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
      body: controller == null
          ? const Center(child: Text('Профиль недоступен'))
          : StateConsumer<ProfileController, ProfileState>(
              controller: controller,
              builder: (context, state, child) {
                final profile = state.profile;
                if (profile == null) {
                  if (state is ProfileStateProcessing) {
                    return Center(child: VmLoader.medium());
                  }

                  return const Center(child: Text('Профиль не найден'));
                }

                return _ProfileTabContent(
                  profile: profile,
                );
              },
            ),
    );
  }
}

class _ProfileTabContent extends StatelessWidget {
  const _ProfileTabContent({
    required this.profile,
  });

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    final photoUrl = profile.photoUrl;
    final heroTag = avatarHeroTag(profile.id);

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 24.0),
          GestureDetector(
            onTap: photoUrl == null ? null : () => _openAvatar(context, photoUrl, heroTag),
            child: AvatarHero(
              tag: heroTag,
              child: VmAvatar.large(
                photoUrl: photoUrl,
                label: profile.firstName,
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Text(
            '${profile.lastName} ${profile.firstName}',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 48.0),
          ListTile(
            leading: const Icon(Icons.mode_edit_outline_outlined),
            onTap: () => VmNavigator.push(context, ProfileEditPage(id: profile.id)),
            title: const Text('Информация'),
          ),
          const ListTile(
            enabled: false,
            leading: Icon(Icons.notifications_none_outlined),
            title: Text('Уведомления'),
          ),
          const ListTile(
            enabled: false,
            leading: Icon(Icons.star_border_outlined),
            title: Text('Отзывы'),
          ),
          const SizedBox(height: 32.0),
          TextButton(
            onPressed: () {},
            child: const Text('Удалить аккаунт'),
          ),
          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: VmButton(
              onPressed: () => AuthenticationScope.signOut(context),
              child: const Text('Выйти'),
            ),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }

  void _openAvatar(BuildContext context, String photoUrl, Object heroTag) {
    VmNavigator.push(
      context,
      AvatarPreviewPage(
        photoUrl: photoUrl,
        heroTag: heroTag,
      ),
    );
  }
}
