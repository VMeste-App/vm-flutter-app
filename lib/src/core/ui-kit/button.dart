import 'package:flutter/material.dart';
import 'package:vm_app/src/core/ui-kit/loader.dart';

class VmButton extends StatelessWidget {
  const VmButton({
    super.key,
    this.onPressed,
    this.icon,
    this.stretched = true,
    this.loading = false,
    this.enabled = true,
    this.child,
  });

  // const VmButton.icon({
  //   super.key,
  //   this.onPressed,
  //   this.icon,
  //   this.loading = false,
  //   this.enabled = true,
  // }) : stretched = false,
  //      child = null;

  final VoidCallback? onPressed;
  final Widget? icon;
  final bool stretched;
  final bool loading;
  final bool enabled;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final isActive = enabled && !loading;

    Widget? effectiveChild = child;
    if (loading) {
      effectiveChild = VmLoader.small();
    } else if (child case final child?) {
      if (icon case final icon?) {
        effectiveChild = Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 12.0,
          children: [icon, child],
        );
      }
    }

    return PressScaleTransition(
      enabled: isActive,
      child: FilledButton(
        style: FilledButton.styleFrom(
          minimumSize: stretched ? null : const Size(0.0, 40.0),
          disabledBackgroundColor: loading ? Colors.black : null,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        onPressed: isActive ? onPressed : null,
        child: effectiveChild,
      ),
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
