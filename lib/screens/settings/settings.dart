import 'package:aishop/screens/cart/checkout_page.dart';
import 'package:aishop/styles/icon_button.dart';
import 'package:aishop/styles/theme.dart';
import 'package:aishop/utils/authentication.dart';
import 'package:aishop/widgets/appbar/appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return new Scaffold(
        appBar: MyAppBar(
          title: Text(
            " ",
          ),
          context: context,
        ),
        body: Container(
          color: mediumblack,
          width: size.width,
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    height: 0,
                    width: size.width * 0.3,
                    color: mediumblack,
                  ),
                  Container(
                    color: white,
                    width: size.width * 0.7,
                    height: 0,
                    padding: EdgeInsets.only(right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        CustomIconButton(
                            icon: Icons.home,
                            press: () => {Navigator.pop(context)}),
                        CustomIconButton(icon: Icons.favorite, press: () => {}),
                        CustomIconButton(icon: Icons.history, press: () => {}),
                        CustomIconButton(
                            icon: Icons.shopping_cart,
                            press: () => {
                                  Navigator.pop(context),
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) => CheckOutPage()))
                                }),
                        CustomIconButton(
                            icon: Icons.settings,
                            press: () => {
                                  Navigator.pop(context),
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) => SettingsPage()))
                                }),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    height: size.height - 60,
                    width: size.width * 0.3,
                    color: lightblack,
                    alignment: Alignment.centerRight,
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Text(
                        "Settings",
                        style: TextStyle(
                            fontFamily: 'Inria Serif',
                            fontSize: 80,
                            fontWeight: FontWeight.w800,
                            color: white),
                      ),
                    ),
                  ),
                  Container(
                    height: size.height - 60,
                    width: size.width * 0.7,
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                    color: white,
                    child: ListView(children: [
                      SizedBox(
                        height: 15,
                      ),
                      Column(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 70,
                            backgroundColor: mediumblack,
                            child: CircleAvatar(
                              radius: 65,
                              backgroundImage: imageUrl != null
                                  ? NetworkImage(imageUrl!)
                                  : null,
                              child: imageUrl == null
                                  ? Icon(Icons.account_circle, size: 120)
                                  : Container(),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Divider(
                            height: 15,
                            thickness: 2,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          buildAccountOptionRow(context, "Change Password"),
                          buildAccountOptionRow(context, "Content settings"),
                          buildAccountOptionRow(context, "Language"),
                          buildAccountOptionRow(
                              context, "Privacy and security"),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.volume_up_outlined,
                                color: lightblack,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                "Notifications",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Divider(
                            height: 15,
                            thickness: 2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "New for you ",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              Transform.scale(
                                  scale: 0.7,
                                  child: CupertinoSwitch(
                                    value: true,
                                    onChanged: (bool val) {},
                                  ))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Account activity",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                              Transform.scale(
                                  scale: 0.7,
                                  child: CupertinoSwitch(
                                    value: true,
                                    onChanged: (bool val) {},
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ]),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  GestureDetector buildAccountOptionRow(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(title),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Option 1"),
                    Text("Option 1"),
                    Text("Option 1"),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Close"),
                  )
                ],
              );
            });
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(5, 25, 3, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}