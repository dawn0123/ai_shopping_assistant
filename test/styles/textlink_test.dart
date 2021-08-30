import 'package:aishop/styles/textlink.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget makeTestableWidget({required Widget child}) {
    return MaterialApp(
      home: child,
    );
  }
  testWidgets('textlink ...', (tester) async {
    // need to finish up test
    TextLink textLink = TextLink(
      text: "Forgot Password?",
      align: Alignment.centerRight,
      press: () {},
    );
  });
}