import 'package:flutter/material.dart';
import 'package:vm_app/src/core/theme/colors.dart';
import 'package:vm_app/src/core/ui-kit/loader.dart';

enum VmButtonStyle {
  primary,
  secondary,
  outline,
  ghost,
}

enum VmButtonRole {
  normal,
  accent,
  destructive,
}

enum VmButtonSize {
  standard,
  medium,
  large
  ;

  double get height => switch (this) {
    VmButtonSize.standard => 40.0,
    VmButtonSize.medium => 44.0,
    VmButtonSize.large => 52.0,
  };

  EdgeInsetsGeometry get padding => switch (this) {
    VmButtonSize.standard => const EdgeInsets.symmetric(horizontal: 16.0),
    VmButtonSize.medium => const EdgeInsets.symmetric(horizontal: 18.0),
    VmButtonSize.large => const EdgeInsets.symmetric(horizontal: 20.0),
  };

  double get iconSize => switch (this) {
    VmButtonSize.standard => 20.0,
    VmButtonSize.medium => 22.0,
    VmButtonSize.large => 24.0,
  };

  VmLoaderSize get loaderSize => switch (this) {
    VmButtonSize.standard => VmLoaderSize.small,
    VmButtonSize.medium => VmLoaderSize.small,
    VmButtonSize.large => VmLoaderSize.medium,
  };
}

enum VmButtonWidth {
  hug,
  fill
  ;

  double? get value => switch (this) {
    VmButtonWidth.hug => null,
    VmButtonWidth.fill => double.infinity,
  };
}

class VmButton extends StatelessWidget {
  const VmButton({
    super.key,
    this.onPressed,
    this.icon,
    this.label,
    this.stretched = true,
    this.width,
    this.style = VmButtonStyle.primary,
    this.role = VmButtonRole.normal,
    this.size = VmButtonSize.standard,
    this.loading = false,
    this.enabled = true,
    this.alignment = Alignment.center,
    this.trailing,
    this.emphasized = false,
    this.iconOnly = false,
    this.child,
  });

  const VmButton.iconOnly({
    super.key,
    required this.label,
    required this.icon,
    this.onPressed,
    this.style = VmButtonStyle.primary,
    this.role = VmButtonRole.normal,
    this.size = VmButtonSize.standard,
    this.width,
    this.loading = false,
    this.enabled = true,
    this.alignment = Alignment.center,
  }) : stretched = false,
       iconOnly = true,
       trailing = null,
       emphasized = false,
       child = null;

  final VoidCallback? onPressed;
  final Widget? icon;
  final String? label;
  final bool stretched;
  final VmButtonWidth? width;
  final VmButtonStyle style;
  final VmButtonRole role;
  final VmButtonSize size;
  final bool loading;
  final bool enabled;
  final Alignment alignment;
  final Widget? trailing;
  final bool emphasized;
  final bool iconOnly;
  final Widget? child;

  bool get _enabled => enabled && !loading && onPressed != null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final resolvedColors = _resolveColors(theme);

    Widget button = iconOnly ? _buildIconButton(theme, resolvedColors) : _buildLabelButton(theme, resolvedColors);

    final semanticLabel = label;
    if (iconOnly && semanticLabel != null) {
      button = Tooltip(message: semanticLabel, child: button);
    }

    return PressScaleTransition(
      enabled: _enabled,
      child: MergeSemantics(child: button),
    );
  }

  ({
    Color bg,
    Color disabledBg,
    Color fg,
    Color disabledFg,
    Color? border,
    Color overlay,
    Color shadow,
    double elevation,
  })
  _resolveColors(ThemeData theme) {
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final neutralSurface = isDark ? AppColors.neutral9 : AppColors.neutral3;
    final neutralForeground = isDark ? AppColors.neutral1 : AppColors.neutral11;
    final subtleBorder = isDark ? AppColors.neutral8 : AppColors.neutral4;

    Color dim(Color color) => color.withValues(alpha: color.a * 0.38);
    Color overlay(Color color) => color.withValues(alpha: 0.08);
    Color shadow(Color color) => color.withValues(alpha: 0.20);

    final roleForeground = switch (role) {
      VmButtonRole.normal => neutralForeground,
      VmButtonRole.accent => AppColors.blue3,
      VmButtonRole.destructive => AppColors.red1,
    };
    final primaryBackground = switch (role) {
      VmButtonRole.normal => scheme.primary,
      VmButtonRole.accent => AppColors.blue3,
      VmButtonRole.destructive => AppColors.red1,
    };
    final primaryForeground = switch (role) {
      VmButtonRole.normal => scheme.onPrimary,
      VmButtonRole.accent || VmButtonRole.destructive => AppColors.neutral1,
    };

    return switch (style) {
      VmButtonStyle.primary => (
        bg: primaryBackground,
        disabledBg: dim(primaryBackground),
        fg: primaryForeground,
        disabledFg: dim(primaryForeground),
        border: null,
        overlay: overlay(primaryForeground),
        shadow: shadow(primaryBackground),
        elevation: _enabled ? 1.0 : 0.0,
      ),
      VmButtonStyle.secondary => (
        bg: role == VmButtonRole.destructive ? AppColors.red1.withValues(alpha: 0.12) : neutralSurface,
        disabledBg: dim(neutralSurface),
        fg: roleForeground,
        disabledFg: dim(roleForeground),
        border: null,
        overlay: overlay(roleForeground),
        shadow: Colors.transparent,
        elevation: 0.0,
      ),
      VmButtonStyle.outline => (
        bg: Colors.transparent,
        disabledBg: Colors.transparent,
        fg: roleForeground,
        disabledFg: dim(roleForeground),
        border: role == VmButtonRole.normal ? subtleBorder : roleForeground,
        overlay: overlay(roleForeground),
        shadow: Colors.transparent,
        elevation: 0.0,
      ),
      VmButtonStyle.ghost => (
        bg: Colors.transparent,
        disabledBg: Colors.transparent,
        fg: roleForeground,
        disabledFg: dim(roleForeground),
        border: null,
        overlay: overlay(roleForeground),
        shadow: Colors.transparent,
        elevation: 0.0,
      ),
    };
  }

  Widget _buildLabelButton(
    ThemeData theme,
    ({
      Color bg,
      Color disabledBg,
      Color fg,
      Color disabledFg,
      Color? border,
      Color overlay,
      Color shadow,
      double elevation,
    })
    colors,
  ) {
    final effectiveWidth = width ?? (stretched ? VmButtonWidth.fill : VmButtonWidth.hug);
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
      side: colors.border != null ? BorderSide(color: colors.border!) : BorderSide.none,
    );
    final buttonStyle = FilledButton.styleFrom(
      minimumSize: Size(effectiveWidth == VmButtonWidth.fill ? double.infinity : 0.0, size.height),
      fixedSize: effectiveWidth == VmButtonWidth.fill ? Size.fromHeight(size.height) : null,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: size.padding,
      elevation: colors.elevation,
      shadowColor: colors.shadow,
      splashFactory: NoSplash.splashFactory,
      backgroundColor: colors.bg,
      disabledBackgroundColor: colors.disabledBg,
      foregroundColor: colors.fg,
      disabledForegroundColor: colors.disabledFg,
      overlayColor: colors.overlay,
      shape: shape,
      alignment: alignment,
      textStyle: theme.textTheme.labelLarge?.copyWith(
        fontWeight: emphasized ? FontWeight.w600 : FontWeight.w500,
      ),
    );

    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: size.height,
        minWidth: effectiveWidth.value ?? 0.0,
      ),
      child: FilledButton(
        style: buttonStyle,
        onPressed: _enabled ? onPressed : null,
        child: _buildButtonContent(colors),
      ),
    );
  }

  Widget _buildIconButton(
    ThemeData theme,
    ({
      Color bg,
      Color disabledBg,
      Color fg,
      Color disabledFg,
      Color? border,
      Color overlay,
      Color shadow,
      double elevation,
    })
    colors,
  ) {
    return IconButton(
      onPressed: _enabled ? onPressed : null,
      iconSize: size.iconSize,
      tooltip: label,
      icon: loading ? VmLoader(size: size.loaderSize, color: colors.fg) : (icon ?? const SizedBox.shrink()),
      style: IconButton.styleFrom(
        fixedSize: Size.square(size.height),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        splashFactory: NoSplash.splashFactory,
        foregroundColor: colors.fg,
        disabledForegroundColor: colors.disabledFg,
        backgroundColor: colors.bg,
        disabledBackgroundColor: colors.disabledBg,
        overlayColor: colors.overlay,
        shadowColor: colors.shadow,
        elevation: colors.elevation,
        alignment: alignment,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: colors.border != null ? BorderSide(color: colors.border!) : BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildButtonContent(
    ({
      Color bg,
      Color disabledBg,
      Color fg,
      Color disabledFg,
      Color? border,
      Color overlay,
      Color shadow,
      double elevation,
    })
    colors,
  ) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Visibility(
          visible: !loading,
          maintainAnimation: true,
          maintainSize: true,
          maintainState: true,
          child: _buildVisibleContent(),
        ),
        if (loading) VmLoader(size: size.loaderSize, color: colors.fg),
      ],
    );
  }

  Widget _buildVisibleContent() {
    final effectiveChild = child ?? (label != null ? Text(label!) : const SizedBox.shrink());
    final hasLeadingOrTrailing = icon != null || trailing != null;

    if (!hasLeadingOrTrailing) {
      return effectiveChild;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 12.0,
      children: [
        if (icon != null)
          IconTheme.merge(
            data: IconThemeData(size: size.iconSize),
            child: icon!,
          ),
        Flexible(child: effectiveChild),
        ?trailing,
      ],
    );
  }
}

/// Notification sent when a [PressScaleTransition] handles a press.
/// Used to prevent ancestor [PressScaleTransition]s from animating.
class _PressScaleNotification extends Notification {
  const _PressScaleNotification();
}

/// A widget that adds a subtle scale down effect when pressed.
///
/// When nested, only the innermost [PressScaleTransition] will animate,
/// preventing unwanted visual effects on parent buttons.
class PressScaleTransition extends StatefulWidget {
  const PressScaleTransition({required this.child, this.enabled = true, super.key});

  final bool enabled;
  final Widget child;

  @override
  State<PressScaleTransition> createState() => _PressScaleTransitionState();
}

class _PressScaleTransitionState extends State<PressScaleTransition> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  bool _childHandledPress = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.97).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (!widget.enabled) return;

    // Notify ancestors that this press is being handled
    const _PressScaleNotification().dispatch(context);

    // Use microtask to check if a child notification arrived first
    Future.microtask(() {
      if (!_childHandledPress && mounted) {
        _controller.forward();
      }
      // Reset flag for next interaction
      _childHandledPress = false;
    });
  }

  Future<void> _handleTapUp(TapUpDetails details) async {
    if (!widget.enabled) return;
    await Future<void>.delayed(const Duration(milliseconds: 50));

    if (!mounted) return;
    await _controller.reverse();
  }

  Future<void> _handleTapCancel() async {
    if (!widget.enabled) return;
    await Future<void>.delayed(const Duration(milliseconds: 50));

    if (!mounted) return;
    await _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<_PressScaleNotification>(
      onNotification: (notification) {
        // A descendant PressScaleTransition is handling the press
        _childHandledPress = true;
        return false; // Continue propagating to further ancestors
      },
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        child: ScaleTransition(scale: _scaleAnimation, child: widget.child),
      ),
    );
  }
}
