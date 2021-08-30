import 'package:aishop/screens/homepage/homepage.dart';
import 'package:aishop/widgets/category/category.dart';
import 'package:aishop/widgets/category/category_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget testWidget = new MediaQuery(
      data: new MediaQueryData(), child: new MaterialApp(home: new HomePage()));
  Widget makeTestableWidget({required Widget child}) {
    return MaterialApp(
      home: child,
    );
  }
  testWidgets('category cards visible ...', (tester) async {
    Category cat = Category();
    await tester.pumpWidget(makeTestableWidget(child: cat));
    expect(find.byType(InkWell), findsWidgets);
    expect(find.byType(CategoryCard), findsWidgets);
    final books = find.widgetWithText(CategoryCard, "Books");
    final shoes = find.widgetWithText(CategoryCard, "Shoes");
    final clothes = find.widgetWithText(CategoryCard, "Clothes");
    expect(books, findsOneWidget);
    expect(shoes, findsOneWidget);
    await tester.drag(find.byType(ListView), Offset(-450.0, 0.0));
    await tester.pump();
    final tech = find.widgetWithText(CategoryCard, "Tech");
    final kitchen = find.widgetWithText(CategoryCard, "Kitchen");
    expect(tech, findsOneWidget);
    expect(kitchen, findsOneWidget);
    expect(clothes, findsOneWidget);
  });
}

