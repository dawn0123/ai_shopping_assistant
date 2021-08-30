import 'package:aishop/styles/round_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget makeTestableWidget({required Widget child}) {
    return MediaQuery(
        data: MediaQueryData(),
        child: Material(
            child: MaterialApp(
          home: child,
        )));
  }
  testWidgets('round textfield ...', (tester) async {
    RoundTextField roundTextField = RoundTextField(autofocus: true);
    await tester.pumpWidget(makeTestableWidget(child: roundTextField));

    final textformfield = find.byType(TextFormField);
    expect(textformfield, findsOneWidget);

    await tester.enterText(textformfield, 'testing text');
    expect(find.text('testing text'), findsOneWidget);
  });
}