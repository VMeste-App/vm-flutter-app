import 'package:flutter/material.dart';
import 'package:vm_app/src/core/theme/colors.dart';

/// {@template event_card}
/// VmAvatar widget.
/// {@endtemplate}
class VmAvatar extends StatelessWidget {
  /// {@macro event_card}
  const VmAvatar({
    super.key, // ignore: unused_element_parameter
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox.square(
      dimension: 32.0,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.neutral4,
          shape: BoxShape.circle,
        ),
        child: Center(child: Text('А')),
      ),
    );
  }
}
