import 'package:aishop/styles/title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget makeTestableWidget({required Widget child}) {
    return MaterialApp(
      home: child,
    );
  }
  testWidgets('title ...', (tester) async {
     PageTitle pageTitle = PageTitle(text: "Login");
    await tester.pumpWidget(makeTestableWidget(child: pageTitle));
  });
}