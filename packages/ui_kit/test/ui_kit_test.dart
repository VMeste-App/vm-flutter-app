import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit/ui_kit.dart';

void main() {
  testWidgets('renders a primary button', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: VmTheme().lightTheme,
        home: VmButton(label: 'Action', onPressed: () {}),
      ),
    );

    expect(find.text('Action'), findsOneWidget);
  });
}
