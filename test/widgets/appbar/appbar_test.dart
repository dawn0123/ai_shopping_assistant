import 'package:aishop/screens/cart/checkout_page.dart';
import 'package:aishop/screens/past_purchases/pastpurchase.dart';
import 'package:aishop/screens/profile_page/edit_profile.dart';
import 'package:aishop/screens/settings/settings.dart';
import 'package:aishop/screens/wishlist/wislistscreen.dart';
import 'package:aishop/widgets/appbar/appbar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
class MockContext extends Mock implements BuildContext {}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Widget testWidget;
  final context = MockContext();
  Firebase.initializeApp().whenComplete(() => {
    testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(home: new MyAppBar(context: context))
    ),
  testWidgets('App icons', (WidgetTester tester) async {
  await tester.pumpWidget(testWidget);

  final wish = find.byKey(Key('wish'));
  final cart = find.byKey(Key('cart'));
  final menu = find.byKey(Key('dropdownmenu'));

  expect(wish, findsOneWidget);
  expect(cart, findsOneWidget);
  expect(menu, findsOneWidget);

  await tester.tap(wish);
  await tester.pumpAndSettle();
  expect(find.byType(WishlistPage), findsOneWidget);

  await tester.tap(wish);
  await tester.pumpAndSettle();
  expect(find.byType(WishlistPage), findsOneWidget);

  await tester.tap(cart);
  await tester.pumpAndSettle();
  expect(find.byType(CheckOutPage), findsOneWidget);

  await tester.tap(menu);
  await tester.pumpAndSettle();
  expect(find.byType(PopupMenuButton), findsOneWidget);

  final settings = find.byKey(Key('settings'));
  final profile = find.byKey(Key('profile'));
  final orders = find.byKey(Key('orders'));
  final signout = find.byKey(Key('signout'));

    await tester.tap(settings);
    await tester.pumpAndSettle();
    expect(find.byType(SettingsPage), findsOneWidget);

    await tester.tap(profile);
    await tester.pumpAndSettle();
    expect(find.byType(EditProfilePage), findsOneWidget);

    await tester.tap(orders);
    await tester.pumpAndSettle();
    expect(find.byType(PastPurchase), findsOneWidget);

    await tester.tap(signout);
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsOneWidget);
  print('======================');
  print('');
  })
  });
}