//password field design do not change.
import 'package:aishop/styles/theme.dart';
import 'package:flutter/material.dart';

class RoundPasswordField extends StatelessWidget {
  final text;
  final press;
  final color, textColor;
  final control;
  final margin;
  final icon;
final  errorborder;
final  errorstyle;
  final errorText;
final submitted;
  final focusNode;
  final autofocus;
  final onChanged;
  final onSubmitted;


  const RoundPasswordField({
    Key? key,
    this.text,
    this.press,
    this.color = lightblack,
    this.textColor = white,
    this.control,
    this.margin,
    this.icon, this.errorborder, this.errorstyle, this.errorText, this.submitted, this.focusNode, this.autofocus, this.onChanged, this.onSubmitted
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        width: size.width * 0.8,
        //height: 50,
        margin: margin,
        child:
        TextFormField(
            autofocus: autofocus,
            onChanged: onChanged,
            controller: control,
            enableSuggestions: false,
            autocorrect: false,
            obscureText: true,
            onFieldSubmitted: submitted,
            decoration:
            InputDecoration(
                fillColor: white,
                hintText: text,
                prefixIcon: icon,
                errorStyle: errorstyle,
                errorText: errorText,
                focusedErrorBorder: errorborder,
                enabledBorder:
                OutlineInputBorder(
                    borderSide:
                    const BorderSide(
                        color: black,
                        width: 2.0),
                    borderRadius:
                    BorderRadius.circular(100)
                ),
                focusedBorder:
                OutlineInputBorder(
                    borderSide:
                    const BorderSide(
                        color: black,
                        width: 2.0),
                    borderRadius:
                    BorderRadius.circular(100)
                ),
              border: OutlineInputBorder(
                  borderSide:
                  const BorderSide(
                      color: black,
                      width: 2.0),
                  borderRadius:
                  BorderRadius.circular(100)
              ),
              errorBorder: OutlineInputBorder(
                  borderSide:
                  const BorderSide(
                      color: black,
                      width: 2.0),
                  borderRadius:
                  BorderRadius.circular(100)
              ),
            ),
            style:
            TextStyle(
                fontFamily: 'Nunito Sans',
                fontWeight: FontWeight.w300)
        )
    );
  }
}