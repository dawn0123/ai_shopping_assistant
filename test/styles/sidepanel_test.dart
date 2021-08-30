import 'package:aishop/styles/sidepanel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
   Widget makeTestableWidget({required Widget child}) {
    return MaterialApp(
      home: child,
    );
  }
  testWidgets('sidepanel ...', (tester) async {
     SidePanel sidePanel = SidePanel();
    await tester.pumpWidget(makeTestableWidget(child: sidePanel));
  });
}