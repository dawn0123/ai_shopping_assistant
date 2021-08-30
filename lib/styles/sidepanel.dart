import 'package:aishop/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';


// DO NOT CHANGE ANYTHING IT WILL CHANGE DESIGN COMPLETELY!!
class SidePanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      FittedBox(
          fit: BoxFit.fill,
          child:
          Align(
              alignment: Alignment.centerRight,
              child: Padding(
                  padding: EdgeInsets.all(40),
                  child:
                  Text("AI\nShopping\nSystem",
                      textAlign: TextAlign.right,
                      style:
                      TextStyle(
                          fontSize: 90,
                          color: white,
                          fontFamily: 'Inria Serif'
                      )
                  )
              )
          )
      );
  }
}