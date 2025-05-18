import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

/// {@template safe_scaffold}
/// SafeScaffold widget.
/// {@endtemplate}
class SafeScaffold extends StatelessWidget {
  /// {@macro safe_scaffold}
  const SafeScaffold({super.key, this.appBar, required this.body, this.persistentFooterButtons});

  final PreferredSizeWidget? appBar;
  final Widget body;
  final List<Widget>? persistentFooterButtons;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.theme.scaffoldStyle.backgroundColor,
        appBar: appBar,
        body: body,
        persistentFooterButtons: persistentFooterButtons,
      ),
    );
  }
}
