//used for decor purposes
import 'package:aishop/styles/theme.dart';
import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Container(
        width: size.width * 0.8,
        child:
        Row(
            children:
            <Widget>[
              Expanded(
                  child: Divider(
                      color: black,
                      thickness: 5)
              ),
              Container(
                  child:
                  Text("OR"),
                  margin:
                  const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0
                  )
              ),
              Expanded(
                  child:
                  Divider(
                      color: black,
                      thickness: 5
                  )
              )
            ]
        )
    );
  }
}