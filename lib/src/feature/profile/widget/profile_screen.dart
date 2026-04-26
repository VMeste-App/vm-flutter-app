import 'package:control/control.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:vm_app/src/core/di/dependencies.dart';
import 'package:vm_app/src/core/navigator/navigator.dart';
import 'package:vm_app/src/feature/profile/controller/profile_controller.dart';
import 'package:vm_app/src/feature/profile/controller/profile_state.dart';
import 'package:vm_app/src/feature/profile/model/profile.dart';
import 'package:vm_app/src/feature/profile/widget/avatar_preview_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
    required this.id,
  });

  final ProfileId id;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final ProfileController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ProfileController(
      id: widget.id,
      repository: Dependencies.of(context).profileRepository,
    )..fetch();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StateConsumer<ProfileController, ProfileState>(
      controller: _controller,
      builder: (context, state, child) {
        final profile = state.profile;

        return VmScaffold(
          appBar: AppBar(
            title: const Text('Профиль'),
            actions: [
              IconButton(
                icon: const Icon(Icons.share_outlined),
                onPressed: profile == null ? null : () {},
              ),
            ],
          ),
          body: switch (profile) {
            final Profile profile => _ProfileContent(profile: profile),
            null when state is ProfileStateProcessing => Center(child: VmLoader.medium()),
            null => const Center(child: Text('Профиль не найден')),
          },
        );
      },
    );
  }
}

class _ProfileContent extends StatelessWidget {
  const _ProfileContent({required this.profile});

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    final photoUrl = profile.photoUrl;
    final heroTag = avatarHeroTag(profile.id);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: GestureDetector(
              onTap: photoUrl == null ? null : () => _openAvatar(context, photoUrl, heroTag),
              child: AvatarHero(
                tag: heroTag,
                child: VmAvatar.large(
                  photoUrl: photoUrl,
                  label: profile.firstName,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Text(
            '${profile.lastName} ${profile.firstName}',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 24.0),
          _InfoTile(
            title: 'Возраст',
            value: '${_calculateAge(profile.birthDate)}',
          ),
          _InfoTile(
            title: 'Пол',
            value: profile.sex.name,
          ),
          if (profile.height case final height?)
            _InfoTile(
              title: 'Рост',
              value: '$height см',
            ),
          if (profile.weight case final weight?)
            _InfoTile(
              title: 'Вес',
              value: '$weight кг',
            ),
          if (profile.aboutMe case final aboutMe? when aboutMe.isNotEmpty)
            _InfoTile(
              title: 'О себе',
              value: aboutMe,
            ),
        ],
      ),
    );
  }

  int _calculateAge(DateTime birthDate) {
    final now = DateTime.now();
    var age = now.year - birthDate.year;
    final hasBirthdayPassed = now.month > birthDate.month || now.month == birthDate.month && now.day >= birthDate.day;
    if (!hasBirthdayPassed) {
      age--;
    }
    return age;
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

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      subtitle: Text(value),
    );
  }
}
