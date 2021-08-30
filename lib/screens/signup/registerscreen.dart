import 'package:aishop/screens/login/loginscreen.dart';
import 'package:aishop/screens/verification_page/verifyscreen.dart';
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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({this.cityName,this.longitude,this.latitude});
  final cityName;
  final longitude;
  final latitude;

  @override
  State<StatefulWidget> createState() {
    return _RegisterScreenState();
  }
}

//ignore: must_be_immutable
class _RegisterScreenState extends State<RegisterScreen> {
//declare and initial the cfield controllers, the focus and check if user is editing the field.
  late TextEditingController userEmailController;
  late FocusNode textFocusNodeEmail = FocusNode();
  bool _isEditingEmail = false;

  late TextEditingController userPasswordController;
  late FocusNode textFocusNodePassword = FocusNode();
  bool _isEditingpassword = false;

  String cityname = "";
  String loginStatus = "";
  late Color loginStringColor;

//use Regular Expression to validate the structure

  late TextEditingController userConfirmPasswordController;
  late FocusNode textFocusNodeConfirmPassword = FocusNode();

  late TextEditingController userFirstNameController;
  late FocusNode textFocusNodeFirstName = FocusNode();

  late TextEditingController userLastNameController;
  late FocusNode textFocusNodeLastName = FocusNode();

  late TextEditingController userBirthdayController;
  late FocusNode textFocusNodeBirthday = FocusNode();

  late TextEditingController userLocationController;
  late FocusNode textFocusNodeLocation = FocusNode();

  @override
  void initState() {
    userEmailController = TextEditingController();
    userEmailController.text = '';

    userPasswordController = TextEditingController();
    userPasswordController.text = '';

    userConfirmPasswordController = TextEditingController();
    userFirstNameController = TextEditingController();
    userLastNameController = TextEditingController();
    userBirthdayController = TextEditingController();
    userLocationController = TextEditingController();

    super.initState();
  }

  String? _validateEmail(String value) {
    value = value.trim();
//check user is enetring a valid email.
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
//check user enters a strong enough password.
    if (userPasswordController.text.isNotEmpty) {
      print(value);
      if (value.isEmpty) {
        return 'Please enter password';
      } else {
        if (!value.contains(new RegExp(r'[0-9]'))) {
          return ' Password must contain atleast one digit ';
        }

        if (!value.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
          return 'Password must contain at least on special character';
        }
        if (!value.contains(new RegExp(r'[a-z]'))) {
          return 'Password must contain at least one lower case letter';
        }

        // if (value.contains(new RegExp(r'[A-Z]'))) {
        //   return 'Password must contain at least one upper case letter';
        // }
      }
    }

    return null;
  }

  String? _checkRepeatedPassword(String value) {
    value = value.trim();
//check that passwords are matching.
    if (userConfirmPasswordController.text.isNotEmpty) {
      if (userConfirmPasswordController.text != userPasswordController.text) {
        return 'Passwords do not match';
      } else {
        return 'Password Confirmed';
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      cityname = widget.cityName.toString();
    });
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
                      padding: EdgeInsets.all(60),
                      decoration: BoxDecoration(color: white),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            //=============================================
                            //heading Signup
                            PageTitle(text: "SIGNUP"),
                            //=============================================

                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                //====================================================================================row
                                children: [
                                  Expanded(
                                      child: RoundTextField(
                                    preicon: Icon(LineIcons.user),
                                    autofocus: false,
                                    margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                    control: userFirstNameController,
                                    text: "First Name",
                                    focusNode: textFocusNodeFirstName,
                                    onSubmitted: (value) {
                                      textFocusNodeFirstName.unfocus();
                                      FocusScope.of(context)
                                          .requestFocus(textFocusNodeLastName);
                                    },
                                  )),
                                  //====================================================================================row
                                  Expanded(
                                      child: RoundTextField(
                                    autofocus: false,
                                    preicon: Icon(LineIcons.user),
                                    margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    control: userLastNameController,
                                    text: "Last Name",
                                    focusNode: textFocusNodeLastName,
                                    onSubmitted: (value) {
                                      textFocusNodeLastName.unfocus();
                                      FocusScope.of(context)
                                          .requestFocus(textFocusNodeEmail);
                                    },
                                  ))
                                ]
                                //====================================================================================rowEnded
                                ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                //====================================================================================row
                                children: <Widget>[
                                  Expanded(
                                      flex: 2,
                                      child: RoundTextField(
                                        preicon: Icon(LineIcons.at),
                                        margin:
                                            EdgeInsets.fromLTRB(0, 0, 10, 0),
                                        focusNode: textFocusNodeEmail,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        textInputAction: TextInputAction.next,
                                        control: userEmailController,
                                        text: "Email",
                                        autofocus: false,
                                        onChanged: (value) {
                                          setState(() {
                                            _isEditingEmail = true;
                                          });
                                        },
                                        onSubmitted: (value) {
                                          textFocusNodeEmail.unfocus();
                                          FocusScope.of(context).requestFocus(
                                              textFocusNodeBirthday);
                                        },
                                        errorText: _isEditingEmail
                                            ? _validateEmail(
                                                userEmailController.text)
                                            : null,
                                        errorstyle:
                                            TextStyle(color: Colors.black54),
                                      )),
                                  //====================================================================================row
                                  Expanded(
                                      flex: 1,
                                      child: RoundTextField(
                                          focusNode: textFocusNodeBirthday,
                                          autofocus: false,
                                          onSubmitted: (value) {
                                            textFocusNodeBirthday.unfocus();
                                            FocusScope.of(context).requestFocus(
                                                textFocusNodePassword);
                                          },
                                          preicon: Icon(LineIcons.birthdayCake),
                                          margin:
                                              EdgeInsets.fromLTRB(10, 0, 0, 0),
                                          control: userBirthdayController,
                                          text: "Birthday",
                                          tap: () => {
                                                FocusScope.of(context)
                                                    .unfocus(),
                                                showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(
                                                        DateTime.now().year -
                                                            100,
                                                        01),
                                                    lastDate: DateTime.now(),
                                                    builder:
                                                        (BuildContext context,
                                                            picker) {
                                                      return Theme(
                                                          // change colors
                                                          data: ThemeData.dark()
                                                              .copyWith(
                                                            colorScheme:
                                                                ColorScheme
                                                                    .dark(
                                                              primary:
                                                                  lightgrey, //highlighter
                                                              onPrimary:
                                                                  black, //text highlighted
                                                              surface:
                                                                  mediumblack,
                                                              onSurface: white,
                                                            ),
                                                            dialogBackgroundColor:
                                                                lightblack,
                                                          ),
                                                          child: (picker)!);
                                                    }).then((pickedDate) {
                                                  if (pickedDate != null) {
                                                    String formattedDate =
                                                        DateFormat('yyyy-MM-dd')
                                                            .format(pickedDate);
                                                    userBirthdayController
                                                        .text = formattedDate;
                                                  }
                                                })
                                              }))
                                ]
                                //====================================================================================rowEnded
                                ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                //====================================================================================row
                                children: <Widget>[
                                  Expanded(
                                      child: RoundPasswordField(
                                    icon: Icon(LineIcons.key),
                                    margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                    text: "Password",
                                    autofocus: false,
                                    control: userPasswordController,
                                    focusNode: textFocusNodePassword,
                                    onSubmitted: (value) {
                                      textFocusNodePassword.unfocus();
                                      FocusScope.of(context).requestFocus(
                                          textFocusNodeConfirmPassword);
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        _isEditingpassword = true;
                                      });
                                    },
                                    errorText: _isEditingpassword
                                        ? _validatePassword(
                                            userPasswordController.text)
                                        : " ",
                                    errorstyle:
                                        TextStyle(color: Colors.black54),
                                  )),
                                  //====================================================================================row
                                  Expanded(
                                      child: RoundPasswordField(
                                    autofocus: false,
                                    icon: Icon(LineIcons.key),
                                    margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    text: "Confirm Password",
                                    control: userConfirmPasswordController,
                                    focusNode: textFocusNodeConfirmPassword,
                                    onSubmitted: (value) {
                                      textFocusNodeConfirmPassword.unfocus();
                                      FocusScope.of(context)
                                          .requestFocus(textFocusNodePassword);
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        _isEditingpassword = true;
                                      });
                                    },
                                    errorText: _isEditingpassword
                                        ? _checkRepeatedPassword(
                                            userConfirmPasswordController.text)
                                        : " ",
                                    errorstyle:
                                        TextStyle(color: Colors.black54),
                                  ))
                                ]),
                            //==================================================
                            //location
                            RoundTextField(
                              text: "${widget.cityName.toString()}",
                              focusNode: textFocusNodeLocation,
                              autofocus: false,
                              control: userLocationController,
                              preicon: Icon(LineIcons.mapMarker),
                              suficon: IconButton(
                                icon: Icon(LineIcons.searchLocation),
                                onPressed: () {},
                              ),
                            ),

                            //=============================================
                            //login button
                            RoundButton(
                              text: "SIGNUP",
                              press: () async {
                                await registerWithEmailPassword(
                                        userEmailController.text,
                                        userPasswordController.text)
                                    .then((result) {
                                  if (result != null) {
                                    setState(() async {
                                      final _firestore =
                                          FirebaseFirestore.instance;
                                      DocumentReference doc_ref = _firestore
                                          .collection("Users")
                                          .doc(uid)
                                          .collection("info")
                                          .doc();
                                      DocumentSnapshot docSnap =
                                          await doc_ref.get();
                                      var doc_id2 = docSnap.reference.id;
                                      if (userLocationController.text == "") {
                                        _firestore
                                            .collection('Users')
                                            .doc(uid)
                                            .collection("info")
                                            .doc(doc_id2)
                                            .set({
                                          'bday': userBirthdayController.text,
                                          'email': userEmailController.text,
                                          'fname': userFirstNameController.text,
                                          'location': widget.cityName,
                                          'lname': userLastNameController.text,
                                          'longitude':widget.longitude,
                                          'latitude':widget.latitude
                                        });
                                      } else {
                                        _firestore
                                            .collection('Users')
                                            .doc(uid)
                                            .collection("info")
                                            .doc(doc_id2)
                                            .set({
                                          'bday': userBirthdayController.text,
                                          'email': userEmailController.text,
                                          'fname': userFirstNameController.text,
                                          'location':
                                              userLocationController.text,
                                          'lname': userLastNameController.text,

                                        });
                                      }
                                      loginStatus =
                                          'You have registered successfully';
                                      loginStringColor = Colors.green;
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  VerifyScreen(
                                                      userEmailController.text,
                                                      widget.cityName,
                                                      userBirthdayController
                                                          .text,
                                                      userFirstNameController
                                                          .text,
                                                      userLastNameController
                                                          .text)));
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
                                              width: 370.0,
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
                                                        "Error has occured !",
                                                        style: TextStyle(
                                                            fontSize: 24.0),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      Text(
                                                        "This account already exist/There's something wrong",
                                                        style: TextStyle(
                                                            fontSize: 15.0,
                                                            color: Colors.red),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 15,
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
                                    loginStringColor = Colors.black54;
                                  });
                                });
                              },
                            ),
                            //=================================================================
                            //or dividers
                            OrDivider(),
                            //==========================================
                            //Google sign in button
                            GoogleRoundButton(),
                            //=============================================
                            // Already registered button => take user to login page
                            TextLink(
                                align: Alignment.center,
                                text: 'Already have an account? Login here.',
                                press: () => {
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen()))
                                    })
                          ])))
            ])));
  }
}