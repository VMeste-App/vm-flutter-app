import 'package:flutter/material.dart';
import 'package:vm_app/src/feature/profile/model/profile.dart';

class AvatarPreviewPage extends Page<void> {
  const AvatarPreviewPage({
    required this.photoUrl,
    required this.heroTag,
  }) : super(key: const ValueKey('avatar-preview'), name: 'avatar-preview');

  final String photoUrl;
  final Object heroTag;

  @override
  Route<void> createRoute(BuildContext context) {
    return PageRouteBuilder<void>(
      settings: this,
      opaque: false,
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 260),
      reverseTransitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, animation, secondaryAnimation) {
        return AvatarPreviewScreen(
          photoUrl: photoUrl,
          heroTag: heroTag,
          animation: animation,
        );
      },
    );
  }
}

class AvatarPreviewScreen extends StatelessWidget {
  const AvatarPreviewScreen({
    super.key,
    required this.photoUrl,
    required this.heroTag,
    required this.animation,
  });

  final String photoUrl;
  final Object heroTag;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    final opacity = CurvedAnimation(
      parent: animation,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );

    return AnimatedBuilder(
      animation: opacity,
      builder: (context, child) {
        return Material(
          color: Colors.black.withValues(alpha: opacity.value),
          child: SafeArea(
            child: Stack(
              children: [
                Center(
                  child: InteractiveViewer(
                    minScale: 1.0,
                    maxScale: 4.0,
                    child: Hero(
                      tag: heroTag,
                      child: Image.network(
                        photoUrl,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => const Icon(
                          Icons.broken_image_outlined,
                          color: Colors.white,
                          size: 48.0,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 8.0,
                  right: 8.0,
                  child: IconButton(
                    color: Colors.white,
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class AvatarHero extends StatelessWidget {
  const AvatarHero({
    super.key,
    required this.tag,
    required this.child,
  });

  final Object tag;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: child,
    );
  }
}

Object avatarHeroTag(ProfileId id) => 'profile-avatar-$id';
