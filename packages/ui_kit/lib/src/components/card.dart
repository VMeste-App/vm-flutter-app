import 'package:flutter/material.dart';
import 'package:ui_kit/src/theme/colors.dart';

enum VmCardTone { surface, elevated, success, accent }

class VmCard extends StatelessWidget {
  const VmCard({
    super.key,
    required this.child,
    this.tone = VmCardTone.surface,
    this.padding = const EdgeInsets.all(20.0),
    this.margin,
    this.onTap,
  });

  final Widget child;
  final VmCardTone tone;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = _resolveColors(Theme.of(context).brightness);

    Widget card = DecoratedBox(
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(28.0),
        border: colors.border == null ? null : Border.all(color: colors.border!),
      ),
      child: Padding(padding: padding, child: child),
    );

    if (onTap != null) {
      final colors = VmThemeColors.of(context);

      card = Material(
        color: colors.transparent,
        child: InkWell(borderRadius: BorderRadius.circular(28.0), onTap: onTap, child: card),
      );
    }

    return Padding(padding: margin ?? EdgeInsets.zero, child: card);
  }

  ({Color background, Color? border}) _resolveColors(Brightness brightness) {
    final colors = VmThemeColors.byBrightness(brightness);

    return switch (tone) {
      VmCardTone.surface => (background: colors.surface, border: colors.border),
      VmCardTone.elevated => (background: colors.surfaceHigh, border: null),
      VmCardTone.success => (background: colors.successMuted, border: null),
      VmCardTone.accent => (background: colors.primaryMuted, border: null),
    };
  }
}
