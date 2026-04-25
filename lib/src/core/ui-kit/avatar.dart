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
    this.photoUrl,
    this.label,
  });

  const VmAvatar.small({
    super.key,
    this.photoUrl,
    this.label,
  }) : size = .small;

  const VmAvatar.medium({
    super.key,
    this.photoUrl,
    this.label,
  }) : size = .medium;

  const VmAvatar.large({
    super.key,
    this.photoUrl,
    this.label,
  }) : size = .large;

  final AvatarSize size;
  final String? photoUrl;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final sizeValue = _buildSize(size);
    final url = photoUrl;

    return SizedBox.fromSize(
      size: sizeValue,
      child: ClipOval(
        child: DecoratedBox(
          decoration: const BoxDecoration(color: AppColors.neutral4),
          child: url == null || url.isEmpty
              ? Center(
                  child: Text(
                    label?.characters.firstOrNull ?? 'А',
                    style: TextStyle(fontSize: _buildTextSize(size)),
                  ),
                )
              : Image.network(
                  url,
                  width: sizeValue.width,
                  height: sizeValue.height,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Center(
                    child: Text(
                      label?.characters.firstOrNull ?? 'А',
                      style: TextStyle(fontSize: _buildTextSize(size)),
                    ),
                  ),
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
