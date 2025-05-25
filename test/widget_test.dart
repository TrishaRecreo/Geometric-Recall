// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:group5/main.dart';

void main() {
  testWidgets('Game initialization test', (WidgetTester tester) async {
    await tester.pumpWidget(const GeometricRecallApp());

    expect(find.text('Geometric Recall'), findsOneWidget);
    expect(find.text('Start Game'), findsOneWidget);
    expect(find.text('How to Play'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('Exit'), findsOneWidget);
  });
}
