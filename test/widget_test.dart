import 'package:flutter_test/flutter_test.dart';
import 'package:kitchen_helper/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const KitchenHelperApp());
  });
}
