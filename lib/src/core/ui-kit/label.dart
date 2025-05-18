import 'package:flutter/material.dart';
import 'package:vm_app/src/core/utils/extensions/context_extension.dart';

class VmLabel extends StatelessWidget {
  const VmLabel({
    super.key,
    this.title,
    this.hint,
    this.error,
    required this.child,
    this.padding,
    this.titlePadding,
    this.hintPadding,
    this.errorPadding,
  });

  final Widget? title;
  final Widget? hint;
  final Widget? error;
  final EdgeInsets? padding;
  final EdgeInsets? titlePadding;
  final EdgeInsets? hintPadding;
  final EdgeInsets? errorPadding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null)
            Padding(
              padding: titlePadding ?? const EdgeInsets.only(bottom: 8.0),
              child: DefaultTextStyle(
                style: context.theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
                child: title!,
              ),
            ),
          Padding(padding: EdgeInsets.zero, child: child),
          if (hint != null)
            Padding(padding: EdgeInsets.zero, child: DefaultTextStyle(style: const TextStyle(), child: hint!)),
          if (error != null)
            Padding(padding: EdgeInsets.zero, child: DefaultTextStyle(style: const TextStyle(), child: error!)),
        ],
      ),
    );
  }
}
