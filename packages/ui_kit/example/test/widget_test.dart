import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_example/main.dart';

void main() {
  testWidgets('renders showcase title', (tester) async {
    await tester.pumpWidget(const UiKitExampleApp());

    expect(find.text('UI Kit'), findsOneWidget);
  });
}
