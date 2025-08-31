import 'package:flutter/material.dart';
import 'package:vm_app/src/core/utils/extensions/context_extension.dart';

/// {@template safe_scaffold}
/// SafeScaffold widget.
/// {@endtemplate}
class SafeScaffold extends StatelessWidget {
  /// {@macro safe_scaffold}
  const SafeScaffold({
    super.key,
    this.appBar,
    required this.body,
    this.persistentFooterButtons,
    this.bottomNavigationBar,
    this.padding = EdgeInsets.zero,
  });

  final PreferredSizeWidget? appBar;
  final Widget body;
  final List<Widget>? persistentFooterButtons;
  final Widget? bottomNavigationBar;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: appBar,
      body: SafeArea(
        child: Padding(
          padding: padding,
          child: body,
        ),
      ),
      persistentFooterButtons: persistentFooterButtons,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
