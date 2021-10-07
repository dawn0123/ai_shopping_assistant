import 'package:aishop/screens/invoices/components/invoice_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../Mocks/mock.dart';

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

  testWidgets('invoice model ...', (tester) async {
    Invoice invoice = Invoice();
    await tester.pumpWidget(makeTestableWidget(child: invoice));
  });
}
