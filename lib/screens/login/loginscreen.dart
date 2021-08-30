import 'package:aishop/screens/homepage/homepage.dart';
import 'package:aishop/screens/signup/registerscreen.dart';
import 'package:aishop/services/networking.dart';
import 'package:aishop/styles/google_round_button.dart';
import 'package:aishop/styles/or_divider.dart';
import 'package:aishop/styles/round_button.dart';
import 'package:aishop/styles/round_passwordfield.dart';
import 'package:aishop/styles/round_textfield.dart';
import 'package:aishop/styles/sidepanel.dart';
import 'package:aishop/styles/textlink.dart';
import 'package:aishop/styles/theme.dart';
import 'package:aishop/styles/title.dart';
import 'package:aishop/utils/authentication.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:line_icons/line_icons.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

// ignore: must_be_immutable
class _LoginScreenState extends State<LoginScreen> {
//declare and initialize the controllers and focus on each field.
//initialize variable to check if user is editing the specific fiels.
  late TextEditingController userEmailController;
  late FocusNode textFocusNodeEmail;
  bool _isEditingEmail = false;
  late TextEditingController userForgotP = TextEditingController();
  String longitude = "";
  String latitude = "";
  late String cityname = "";

  late TextEditingController userPasswordController;
  late FocusNode textFocusNodePassword;
  bool _isEditingpassword = false;

  String loginStatus = "";
  late Color loginStringColor;

  @override
  void initState() {
    getLocationData();
    userEmailController = TextEditingController();
    userEmailController.text = '';
    textFocusNodeEmail = FocusNode();

    userPasswordController = TextEditingController();
    userPasswordController.text = '';
    textFocusNodePassword = FocusNode();
    super.initState();
  }

  String? _validateEmail(String value) {
    value = value.trim();
// validate the email input that the usr gives.
    if (userEmailController.text.isNotEmpty) {
      if (value.isEmpty) {
        return 'Email can\'t be empty';
      } else if (!value.contains(RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
        return 'Enter a correct email address';
      }
    }

    return null;
  }

  String? _validatePassword(String value) {
    value = value.trim();
//makesure user creates a strong password
    if (userPasswordController.text.isNotEmpty) {
      if (value.isEmpty) {
        return 'Please enter password';
      }
    }

    return null;
  }

  void getLocationData() async {
    print("running location data function");
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    print("done with Geolocator+${position.longitude}");
    longitude = await position.longitude.toString();
    latitude = await position.latitude.toString();
    NetworkHelper networkHelper = await NetworkHelper(
        'http://api.positionstack.com/v1/reverse?access_key=5e65a2bf717cff420bade43bf75f0cec&query=$latitude,$longitude');
    await networkHelper.getData();
    cityname = networkHelper.cityname;

  }

//test keys
  static const notRegisteredTextKey = Key('notRegisteredTextKey');
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return new Scaffold(
        body: Container(
            width: size.width,
            height: size.height,
            color: lightblack,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: <
                Widget>[
              Expanded(child: SidePanel()),
              Expanded(
                  child: Container(
                      color: white,
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.1,
                          vertical: size.height * 0.1),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            //=============================================
                            //heading login
                            PageTitle(
                              text: "LOGIN",
                            ),
                            //=============================================
                            //Email text field
                            RoundTextField(
                              focusNode: textFocusNodeEmail,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              control: userEmailController,
                              text: "Email",
                              autofocus: false,
                              preicon: Icon(LineIcons.user),
                              onChanged: (value) {
                                setState(() {
                                  _isEditingEmail = true;
                                });
                              },
                              onSubmitted: (value) {
                                textFocusNodeEmail.unfocus();
                                //FocusScope.of(context).requestFocus(textFocusNodePassword);
                              },
                              errorText: _isEditingEmail
                                  ? _validateEmail(userEmailController.text)
                                  : "",
                              errorstyle: TextStyle(
                                color: Colors.black54,
                              ),
                            ),
                            //=============================================
                            //Password text field
                            RoundPasswordField(
                              control: userPasswordController,
                              text: "Password",
                              icon: Icon(LineIcons.key),
                              autofocus: false,
                              onChanged: (value) {
                                setState(() {
                                  _isEditingpassword = true;
                                });
                              },
                              onSubmitted: (value) {
                                textFocusNodePassword.unfocus();
                              },
                              errorText: _isEditingpassword
                                  ? _validatePassword(
                                      userPasswordController.text)
                                  : "",
                              errorstyle: TextStyle(color: Colors.black54),
                            ),
                            //=============================================
                            //login button
                            RoundButton(
                              text: "LOGIN",
                              press: () async {
                                await signInWithEmailPassword(
                                        userEmailController.text,
                                        userPasswordController.text)
                                    .then((result) {
                                  if (result != null) {
                                    setState(() {
                                      loginStatus =
                                          'You have signed in successfully';
                                      loginStringColor = Colors.green;
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  HomePage()));
                                    });
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(32.0))),
                                            contentPadding:
                                                EdgeInsets.only(top: 10.0),
                                            content: Container(
                                              width: 300.0,
                                              // height: 30,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      Text(
                                                        "Error has occured",
                                                        style: TextStyle(
                                                            fontSize: 24.0),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      Text(
                                                        "Your Password/Email is incorrect",
                                                        style: TextStyle(
                                                            fontSize: 13.0,
                                                            color: Colors.red),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  TextButton(
                                                    child: Text('OK',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black)),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  }
                                }).catchError((error) {
                                  print('Sign in Error: $error');
                                  setState(() {
                                    loginStatus =
                                        'Error occured while Signing in';
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) =>
                                                LoginScreen()));
                                    loginStringColor = Colors.red;
                                  });
                                });
                              },
                            ),
                            //=============================================
                            TextLink(
                                text: "Forgot Password?",
                                align: Alignment.centerRight,
                                press: () => {
                                      Alert(
                                          context: context,
                                          title:
                                              "Enter email for password reset",
                                          content: Column(
                                            children: <Widget>[
                                              TextField(
                                                decoration: InputDecoration(
                                                  icon: Icon(LineIcons.user),
                                                  labelText: 'E-mail',
                                                ),
                                                controller: userForgotP,
                                              ),
                                            ],
                                          ),
                                          buttons: [
                                            DialogButton(
                                              onPressed: () {
                                                resetPassword(userForgotP.text);

                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                "Send email",
                                                style: TextStyle(
                                                    color: white, fontSize: 20),
                                              ),
                                              color: lightblack,
                                            ),
                                            DialogButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: Text(
                                                "Cancel",
                                                style: TextStyle(
                                                    color: white, fontSize: 20),
                                              ),
                                              color: lightblack,
                                            )
                                          ]).show(),
                                    }),
                            //=========================================
                            //or dividers
                            OrDivider(),
                            //==========================================
                            //Google sign in button
                            GoogleRoundButton(),
                            //==========================================
                            TextLink(
                                key: notRegisteredTextKey,
                                text: "Not Registered?",
                                align: Alignment.center,
                                press: () => {
                                      print(cityname),
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  RegisterScreen(
                                                    cityName:
                                                        cityname.toString(),
                                                    longitude: longitude,
                                                    latitude: latitude,
                                                  ))),
                                    })
                            //=====================================================
                          ])))
            ])));
  }
}