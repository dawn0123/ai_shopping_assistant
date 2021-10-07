import 'package:aishop/screens/settings/settings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../Mocks/mock.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
  });
  Widget makeTestableWidget({required Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('settings ...', (tester) async {
    SettingsPage settingsPage = SettingsPage();
    await tester.pumpWidget(makeTestableWidget(child: settingsPage));

  });
}
