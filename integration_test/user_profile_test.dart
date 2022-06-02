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
    // await Future.delayed(const Duration(seconds: 20));

    //final skipElevatedButton = find.byKey(const ValueKey(WidgetKeys.skipElevatedButton));
    /*if(skipElevatedButton.precache()) {
      await tester.tap(skipElevatedButton);
      await tester.pumpAndSettle(const Duration(seconds: 5));
      await openUserAccountPage(tester);
    } else {
      await openUserAccountPage(tester);
    }*/
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