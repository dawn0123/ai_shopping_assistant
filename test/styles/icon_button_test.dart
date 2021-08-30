import 'package:aishop/styles/icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget makeTestableWidget({required Widget child}) {
    return Material(
      child: new Directionality(
          textDirection: TextDirection.rtl,
          child: child
      )
    );
  }

  testWidgets('Custom icon button', (tester) async {
    CustomIconButton customIconButton = CustomIconButton();
    await tester.pumpWidget(makeTestableWidget(child: customIconButton));

    final iconButton = find.byType(IconButton);
    expect(iconButton, findsOneWidget);
  });
}