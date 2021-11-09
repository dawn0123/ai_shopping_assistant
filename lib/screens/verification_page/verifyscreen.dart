import 'dart:async';

import 'package:aishop/navigation/locator.dart';
import 'package:aishop/navigation/routing/route_names.dart';
import 'package:aishop/services/navigation_service.dart';
import 'package:aishop/styles/theme.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyScreen extends StatefulWidget {
  final String email, location, birthday, firstname, lastname;
  VerifyScreen(this.email, this.location, this.birthday, this.firstname, this.lastname);

  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final auth = FirebaseAuth.instance;
  late User user;
  late Timer timer;

  get birthday => birthday;
  get email => email;
  get firstname => firstname;
  get lastname => lastname;
  get location => location;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: lightblack,
        child: DefaultTextStyle(
          style: const TextStyle(
            fontSize: 40.0,
            color: white
          ),
          child: AnimatedTextKit(
            animatedTexts: [
              WavyAnimatedText('Please check email for verification link'),

            ],
            isRepeatingAnimation: true,
            onTap: () {
              print("Tap Event");
            },
          ),
        ),
      ),
    );
  }


  Future<void> checkVerification() async {
    user = auth.currentUser!;
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();
      locator<NavigationService>()
                                        .globalNavigateTo(HomeRoute, context);
      // Navigator.push(
      //     context,
      //     new MaterialPageRoute(
      //         builder: (context) =>
      //             HomePage()));
    }
  }

  @override
  void initState() {
    user = auth.currentUser!;
    user.sendEmailVerification();

    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      checkVerification();
    });
    super.initState();
  }
}