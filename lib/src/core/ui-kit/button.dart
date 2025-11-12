import 'package:flutter/material.dart';

class VmButton extends StatelessWidget {
  const VmButton({
    super.key,
    this.onPressed,
    this.loading = false,
    this.child,
  });

  final VoidCallback? onPressed;
  final bool loading;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final effectiveChild = loading ? const _ProgressIndicator() : child;

    return FilledButton(
      style: FilledButton.styleFrom(disabledBackgroundColor: Colors.black),
      onPressed: !loading ? onPressed : null,
      child: effectiveChild,
    );
  }
}

class _ProgressIndicator extends StatelessWidget {
  const _ProgressIndicator();

  @override
  Widget build(BuildContext context) {
    return const RepaintBoundary(
      child: SizedBox.square(
        dimension: 20.0,
        child: CircularProgressIndicator(
          strokeWidth: 2.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
