//textfield design do not change a thing!!
import 'package:aishop/styles/theme.dart';
import 'package:flutter/material.dart';

class RoundTextField extends StatelessWidget {
  final text;
  final  press;
  final  color, textColor;
  final  control;
  final margin;
  final preicon;
  final tap;
  final suficon;
  final submitted;
  final errorText;
  final errorborder;
  final errorstyle;
  final validate;
  final focusNode;
  final keyboardType;
  final textInputAction;
  final autofocus;
  final onChanged;
  final onSubmitted;


  const RoundTextField({
    Key? key,
    this.text,
    this.press,
    this.color = lightblack,
    this.textColor = white,
    this.control,
    this.margin,
    this.preicon,
    this.tap,
    this.suficon,
    this.submitted,
    this.errorText,
    this.errorborder,
    this.errorstyle,
    this.validate,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.autofocus,
    this.onChanged,
    this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        width: size.width * 0.8,
        margin: margin,
        child:
        TextFormField(
          focusNode: focusNode,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          autofocus: autofocus,
          onChanged: onChanged,
          controller: control,
          onTap: tap,
          onFieldSubmitted: submitted,
          decoration:
          InputDecoration(
            enabled: true,
              prefixIcon: preicon,
              suffixIcon: suficon,
              fillColor: white,
              hintText: text,
              errorText: errorText,
              errorStyle: errorstyle,
              focusedErrorBorder: errorborder,
              enabledBorder:
              OutlineInputBorder(
                  borderSide:
                  const BorderSide(
                      color: black,
                      width: 2.0
                  ),
                  borderRadius:
                  BorderRadius.circular(100)
              ),
              focusedBorder:
              OutlineInputBorder(
                  borderSide:
                  const BorderSide(
                      color: black,
                      width: 2.0
                  ),
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
              fontWeight: FontWeight.w300
          ),
        )
    );
  }
}