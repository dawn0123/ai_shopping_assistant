//this class is used to design the google button with a white background and a black border

import 'package:aishop/screens/homepage/homepage.dart';
import 'package:aishop/styles/theme.dart';
import 'package:aishop/utils/authentication.dart';
import 'package:flutter/material.dart';

class GoogleRoundButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GoogleButtonState();
  }
}

class _GoogleButtonState extends State<GoogleRoundButton> {
  late final text;
  late final press;
  late final Color color, textColor;
  late final icon;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        height: 50,
        width: size.width,
        child: ElevatedButton(
          child: Text('Sign in with Google'),
          style: ElevatedButton.styleFrom(
              onPrimary: black,
              primary: white,
              textStyle: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Nunito Sans',
                  fontWeight: FontWeight.w900),
              side: BorderSide(color: black, width: 2),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100))),
          onPressed: () async {
            await signInWithGoogle().then((result) {
              if (result != null) {
                Navigator.push(
                  context,
                  new MaterialPageRoute(builder: (context) => HomePage()),
                );
              }
            }).catchError((error) {
              print('Registration Error: $error');
            });
          }, //login button on pressed
        ));
  }
}
