import 'package:aishop/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';


//page title for login and sign up
class PageTitle extends StatelessWidget {
  final text;

  const PageTitle({
    Key? key,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  SizedBox(
        width: size.width * 0.8,
        child:
        Text(text,
            textAlign: TextAlign.center,
            style:
            TextStyle(
                color: black,
                fontSize: 30
            )
        )
    );
  }
}