import 'package:flutter/material.dart';
import 'package:ui_kit/src/theme/colors.dart';
import 'package:ui_kit/src/theme/typography.dart';

enum VmChipTone { neutral, accent, success, danger }

class VmChip extends StatelessWidget {
  const VmChip({
    super.key,
    required this.label,
    this.selected = false,
    this.tone = VmChipTone.neutral,
    this.leading,
    this.trailing,
    this.onPressed,
  });

  final String label;
  final bool selected;
  final VmChipTone tone;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = _resolveColors(Theme.of(context).brightness);

    return Material(
      color: colors.background,
      borderRadius: BorderRadius.circular(999.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(999.0),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 8.0,
            children: [
              if (leading != null)
                IconTheme.merge(
                  data: IconThemeData(color: colors.foreground, size: 18.0),
                  child: leading!,
                ),
              Text(label, style: VmTextStyles.labelLarge.copyWith(color: colors.foreground)),
              if (trailing != null)
                IconTheme.merge(
                  data: IconThemeData(color: colors.foreground, size: 18.0),
                  child: trailing!,
                ),
            ],
          ),
        ),
      ),
    );
  }

  ({Color background, Color foreground}) _resolveColors(Brightness brightness) {
    final colors = VmThemeColors.byBrightness(brightness);

    if (selected) {
      return (background: colors.textPrimary, foreground: colors.background);
    }

    return switch (tone) {
      VmChipTone.neutral => (background: colors.surfaceHigh, foreground: colors.textSecondary),
      VmChipTone.accent => (background: colors.primaryMuted, foreground: colors.primary),
      VmChipTone.success => (background: colors.successMuted, foreground: colors.success),
      VmChipTone.danger => (background: colors.dangerMuted, foreground: colors.danger),
    };
  }
}
