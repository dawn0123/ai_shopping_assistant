//Text link for forgot password and the link to take user to register page are designed here.
//do not change
import 'package:aishop/styles/theme.dart';
import 'package:flutter/material.dart';

class TextLink extends StatelessWidget {
  final  text;
  final  press;
  final align;

  const TextLink({
    Key? key,
    this.text,
    this.press,
    this.align

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Container(
        width: size.width * 0.8,
        child:
        Align(
          alignment: align,
            child: TextButton(
                child:
                Text(text),
                style:
                TextButton.styleFrom(
                    primary: black,
                    textStyle:
                    TextStyle(
                        fontSize: 18,
                        fontFamily: 'Nunito Sans',
                        fontWeight: FontWeight.w500
                    )
                ),
                //Not registered on presssed => must take user to register page
                onPressed: press
            )
        )
    );
  }
}