//
import 'package:aishop/styles/theme.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final icon;
  final press;

  const CustomIconButton({
    Key? key,
    this.press,
    this.icon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        width: 50,

        child: IconButton(
            icon:  Icon(
              icon, size: 30,
              color: white,
            ),
            onPressed: press,
        )
    );
  }
}