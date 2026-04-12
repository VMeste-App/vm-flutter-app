import 'package:flutter/material.dart';

class InitializationScreen extends StatelessWidget {
  const InitializationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement initialization screen.
    return const Material(child: Directionality(textDirection: TextDirection.ltr, child: Scaffold()));
  }
}
