import 'package:aishop/screens/login/loginscreen.dart';
import 'package:aishop/screens/signup/registerscreen.dart';
import 'package:aishop/styles/google_round_button.dart';
import 'package:aishop/styles/or_divider.dart';
import 'package:aishop/styles/round_button.dart';
import 'package:aishop/styles/round_passwordfield.dart';
import 'package:aishop/styles/round_textfield.dart';
import 'package:aishop/styles/textlink.dart';
import 'package:aishop/styles/title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget testWidget = new MediaQuery(
      data: new MediaQueryData(),
      child: new MaterialApp(home: new LoginScreen())
  );

  final emailField = find.byType(RoundTextField);
  final passwordField = find.byType(RoundPasswordField);
  final signinbutton = find.byType(RoundButton);
  final googlebutton = find.byType(GoogleRoundButton);

  testWidgets('Invalid email and password', (WidgetTester tester) async {
  await tester.pumpWidget(testWidget);

  expect(find.byType(PageTitle), findsOneWidget);
  expect(emailField, findsOneWidget);
  expect(passwordField, findsOneWidget);
  expect(signinbutton, findsOneWidget);
  expect(googlebutton, findsOneWidget);
  expect(find.byType(TextLink), findsNWidgets(2));
  expect(find.byType(OrDivider), findsOneWidget);

  await tester.enterText(emailField, 'test email');
  expect(find.text('test email'), findsOneWidget);

  await tester.enterText(passwordField, 'test password');
  expect(find.text('test password'), findsOneWidget);

  final dialog = find.byType(AlertDialog);

  await tester.tap(signinbutton);
  await tester.pump();
  expect(dialog, findsNothing);

  print('======================');
  print('');
});

  testWidgets('Valid email and invalid password', (WidgetTester tester) async {
    await tester.pumpWidget(testWidget);

    expect(find.byType(PageTitle), findsOneWidget);
    expect(emailField, findsOneWidget);
    expect(passwordField, findsOneWidget);
    expect(signinbutton, findsOneWidget);
    expect(googlebutton, findsOneWidget);
    expect(find.byType(TextLink), findsNWidgets(2));
    expect(find.byType(OrDivider), findsOneWidget);

    await tester.enterText(emailField, 'tester@gmail.com');
    expect(find.text('tester@gmail.com'), findsOneWidget);
    print('valid email');

    await tester.enterText(passwordField, 'test password');
    expect(find.text('test password'), findsOneWidget);
    print('invalid password');

    final dialog = find.byType(AlertDialog);

    await tester.tap(signinbutton);
    await tester.pump();
    expect(dialog, findsNothing);

    print('======================');
    print('');
  });

  testWidgets('invalid email and valid password', (WidgetTester tester) async {
    await tester.pumpWidget(testWidget);

    expect(find.byType(PageTitle), findsOneWidget);
    expect(emailField, findsOneWidget);
    expect(passwordField, findsOneWidget);
    expect(signinbutton, findsOneWidget);
    expect(googlebutton, findsOneWidget);
    expect(find.byType(TextLink), findsNWidgets(2));
    expect(find.byType(OrDivider), findsOneWidget);

    await tester.enterText(emailField, 'test email');
    expect(find.text('test email'), findsOneWidget);

    await tester.enterText(passwordField, '1234@Test');
    expect(find.text('1234@Test'), findsOneWidget);

    final dialog = find.byType(AlertDialog);

    await tester.tap(signinbutton);
    await tester.pump();
    expect(dialog, findsNothing);

    print('======================');
    print('');
  });

  testWidgets('valid email and valid password', (WidgetTester tester) async {
    await tester.pumpWidget(testWidget);

    expect(find.byType(PageTitle), findsOneWidget);
    expect(emailField, findsOneWidget);
    expect(passwordField, findsOneWidget);
    expect(signinbutton, findsOneWidget);
    expect(googlebutton, findsOneWidget);
    expect(find.byType(TextLink), findsNWidgets(2));
    expect(find.byType(OrDivider), findsOneWidget);

    await tester.enterText(emailField, 'tester@gmail.com');
    expect(find.text('tester@gmail.com'), findsOneWidget);

    await tester.enterText(passwordField, '12345@Test');
    expect(find.text('12345@Test'), findsOneWidget);

    final dialog = find.widgetWithText(AlertDialog, 'error occurs');

    await tester.tap(signinbutton);
    await tester.pumpAndSettle();
    expect(dialog, findsNothing);

    //print(dialog);

    print('======================');
    print('');
  });

  testWidgets('No account', (WidgetTester tester) async {
    await tester.pumpWidget(testWidget);

    expect(find.byType(PageTitle), findsOneWidget);
    expect(emailField, findsOneWidget);
    expect(passwordField, findsOneWidget);
    expect(signinbutton, findsOneWidget);
    expect(googlebutton, findsOneWidget);
    expect(find.byType(TextLink), findsNWidgets(2));
    expect(find.byType(OrDivider), findsOneWidget);

    final noAccountLink = find.widgetWithText(TextLink, "Not Registered?");

    await tester.tap(noAccountLink);
    await tester.pumpAndSettle();
    expect(find.byType(RegisterScreen), findsOneWidget);

    print('======================');
    print('');
  });
}