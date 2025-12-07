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
    this.backgroundColor,
    required this.body,
    this.persistentFooterButtons,
    this.bottomNavigationBar,
  });

  final PreferredSizeWidget? appBar;
  final Color? backgroundColor;
  final Widget body;
  final List<Widget>? persistentFooterButtons;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? context.theme.scaffoldBackgroundColor,
      appBar: appBar,
      body: SafeArea(child: body),
      persistentFooterButtons: persistentFooterButtons,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
