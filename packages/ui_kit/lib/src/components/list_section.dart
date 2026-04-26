import 'package:flutter/material.dart';
import 'package:ui_kit/src/components/card.dart';
import 'package:ui_kit/src/theme/colors.dart';
import 'package:ui_kit/src/theme/typography.dart';

class VmListSection extends StatelessWidget {
  const VmListSection({super.key, required this.children, this.padding = const EdgeInsets.symmetric(vertical: 14.0)});

  final List<Widget> children;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return VmCard(
      padding: padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var index = 0; index < children.length; index++) ...[
            children[index],
            if (index != children.length - 1) const Divider(height: 1.0, indent: 72.0),
          ],
        ],
      ),
    );
  }
}

class VmListSectionTile extends StatelessWidget {
  const VmListSectionTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.destructive = false,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool destructive;

  @override
  Widget build(BuildContext context) {
    final colors = VmThemeColors.of(context);
    final textColor = destructive ? colors.danger : colors.textPrimary;
    final mutedColor = colors.textSecondary;

    return ListTile(
      minTileHeight: 72.0,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24.0),
      leading: leading == null
          ? null
          : IconTheme.merge(
              data: IconThemeData(color: textColor, size: 28.0),
              child: leading!,
            ),
      title: Text(title, style: VmTextStyles.bodyLarge.copyWith(color: textColor)),
      subtitle: subtitle == null ? null : Text(subtitle!, style: VmTextStyles.bodyMedium.copyWith(color: mutedColor)),
      trailing: trailing ?? Icon(Icons.chevron_right, color: mutedColor, size: 32.0),
      onTap: onTap,
    );
  }
}
