import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kitchen_helper/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const KitchenHelperApp());
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.byType(KitchenHelperApp), findsOneWidget);
    // Dispose tree before test ends to cancel repeating ticker
    await tester.pumpWidget(const SizedBox());
  });
}
