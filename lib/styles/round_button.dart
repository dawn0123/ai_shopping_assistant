//
import 'package:aishop/styles/theme.dart';
import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final text;
  final press;
  final Color color, textColor;
  const RoundButton({
    Key? key,
    this.text,
    this.press,
    this.color = lightblack,
    this.textColor = white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        height: 50,
        width: size.width * 0.8,
        child: ElevatedButton(
            child: Text(text),
            style:
            ElevatedButton.styleFrom(
                primary: lightblack,
                onPrimary: white,
                textStyle:
                TextStyle(
                  fontSize: 18,
                  fontFamily: 'Nunito Sans',
                  fontWeight: FontWeight.w300,
                ),
                side:
                BorderSide(
                    color: black,
                    width: 2),
                shape:
                RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(100)
                )
            ),
            onPressed: press
        )
    );
  }
}