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
import 'package:line_icons/line_icons.dart';

void main() {
  Widget testWidget = new MediaQuery(
      data: new MediaQueryData(),
      child: new MaterialApp(home: new RegisterScreen())
  );

  final input_fields = find.byType(RoundTextField);
  final pass_fields = find.byType(RoundPasswordField);

  final emailField = find.widgetWithText(RoundTextField, "Email");
  final passwordField = find.widgetWithText(RoundPasswordField, "Password");
  final confirmPassField = find.widgetWithText(RoundPasswordField, "Confirm Password");
  final locationField = find.byIcon(LineIcons.mapMarker);
  final birthdayField = find.widgetWithText(RoundTextField, "Birthday");
  final nameField = find.widgetWithText(RoundTextField, "First Name");
  final surnameField = find.widgetWithText(RoundTextField, "Last Name");
  final signupbutton = find.byType(RoundButton);
  final googlebutton = find.byType(GoogleRoundButton);

  testWidgets('Enabled widgets', (WidgetTester tester) async {
    await tester.pumpWidget(testWidget);

    expect(input_fields, findsNWidgets(5));
    expect(pass_fields, findsNWidgets(2));

    expect(find.byType(PageTitle), findsOneWidget);
    expect(confirmPassField, findsOneWidget);
    expect(locationField, findsOneWidget);
    expect(birthdayField, findsOneWidget);
    expect(nameField, findsOneWidget);
    expect(surnameField, findsOneWidget);
    expect(emailField, findsOneWidget);
    expect(passwordField, findsOneWidget);
    expect(signupbutton, findsOneWidget);
    expect(googlebutton, findsOneWidget);
    expect(find.byType(TextLink), findsOneWidget);
    expect(find.byType(OrDivider), findsOneWidget);

    await tester.enterText(nameField, 'name');
    expect(find.text('name'), findsOneWidget);

    await tester.enterText(passwordField, 'surname');
    expect(find.text('surname'), findsOneWidget);

    await tester.enterText(emailField, 'test email');
    expect(find.text('test email'), findsOneWidget);

    await tester.enterText(passwordField, 'test password');
    expect(find.text('test password'), findsOneWidget);

    await tester.enterText(confirmPassField, 'test c password');
    expect(find.text('test c password'), findsOneWidget);

    await tester.enterText(birthdayField, '00/00/0000');
    expect(find.text('00/00/0000'), findsOneWidget);
    final dialog = find.byType(AlertDialog);

    await tester.tap(signupbutton);
    await tester.pump();
    expect(dialog, findsNothing);

    final alreadyhaveaccount = find.widgetWithText(TextLink, 'Already have an account? Login here.');

    await tester.tap(alreadyhaveaccount);
    await tester.pumpAndSettle();
    expect(find.byType(LoginScreen), findsOneWidget);

    print('======================');
    print('');
  });
}