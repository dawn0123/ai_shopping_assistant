import 'package:aishop/styles/google_round_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget makeTestableWidget({required Widget child}) {
    return MaterialApp(
      home: child,
    );
  }
  testWidgets('google round button ...', (tester) async {
    GoogleRoundButton googleRoundButton = GoogleRoundButton();
    await tester.pumpWidget(makeTestableWidget(child: googleRoundButton));
  });
}