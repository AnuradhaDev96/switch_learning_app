import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../lib/constants/widget_keys.dart';
import '../lib/main.dart' as app;

main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('User profile test', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle(const Duration(seconds: 10));
    await openUserAccountPage(tester);
  });
}

openUserAccountPage(WidgetTester tester) async {
  final userProfileBtn = find.byKey(const ValueKey(WidgetKeys.userProfileIconButton));
  expect(userProfileBtn, findsOneWidget);
  await tester.tap(userProfileBtn);
  await tester.pumpAndSettle(const Duration(seconds: 5));

  expect(find.text('User Account'), findsOneWidget);
}