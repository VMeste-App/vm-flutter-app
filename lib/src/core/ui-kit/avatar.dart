import 'package:flutter/material.dart';
import 'package:vm_app/src/core/theme/colors.dart';

enum AvatarSize {
  small,
  medium,
  large,
}

class VmAvatar extends StatelessWidget {
  const VmAvatar({
    super.key,
    required this.size,
  });

  const VmAvatar.small({
    super.key,
  }) : size = .small;

  const VmAvatar.medium({
    super.key,
  }) : size = .medium;

  const VmAvatar.large({
    super.key,
  }) : size = .large;

  final AvatarSize size;

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: _buildSize(size),
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: AppColors.neutral4,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            'А',
            style: TextStyle(fontSize: _buildTextSize(size)),
          ),
        ),
      ),
    );
  }

  Size _buildSize(AvatarSize size) {
    return switch (size) {
      .small => const Size.square(32.0),
      .medium => const Size.square(64.0),
      .large => const Size.square(96.0),
    };
  }

  double _buildTextSize(AvatarSize size) {
    return switch (size) {
      .small => 8.0,
      .medium => 16.0,
      .large => 48.0,
    };
  }
}
