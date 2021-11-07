import 'dart:ui';

import 'package:aishop/navigation/locator.dart';
import 'package:aishop/navigation/routing/router.dart';
import 'package:aishop/screens/homepage/homepage.dart';
import 'package:aishop/screens/login/loginscreen.dart';
import 'package:aishop/services/databasemanager.dart';
import 'package:aishop/utils/authentication.dart';
import 'package:flutter/material.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  bool auto = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      home: auto == false ? LoginScreen() : HomePage(),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: generateRoute,
    );
  }

//check if user is already logged in in the previous session.
  //get user info if logged in.
  Future getUserInfo() async {
    await getUser();
    setState(() {
      if (uid != null) {
        auto = true;
      }
    });
    print(uid);
  }

  Future getProducts() async {
    await DatabaseManager().setBooks();
    await DatabaseManager().setClothes();
    await DatabaseManager().setKitchen();
    await DatabaseManager().setShoes();
    await DatabaseManager().setTech();
  }

  //remove debug banner in the corner
  void initState() {
    getUserInfo();
    super.initState();
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}
