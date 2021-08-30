import 'package:aishop/screens/cart/components/order_review.dart';
import 'package:aishop/screens/delivery/checkoutdelivery.dart';
import 'package:aishop/screens/delivery/first_delivery_page.dart';
import 'package:aishop/screens/homepage/homepage.dart';
import 'package:aishop/styles/round_textfield.dart';
import 'package:aishop/styles/textlink.dart';
import 'package:aishop/styles/theme.dart';
import 'package:aishop/utils/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CheckOutAddress extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CheckOutAddress();
  }
}

class _CheckOutAddress extends State<CheckOutAddress> {
  Future getUserInfofromdb() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    CollectionReference _collectionReference = _firestore.collection("Users");
    DocumentReference _doc = _collectionReference.doc(uid);
    DocumentReference _documentReference = _doc.collection("info").doc(uid);

    _documentReference.get().then((documentSnapshot) => {
          if (!documentSnapshot.exists)
            {
              print("Sorry, User profile not found."),
            }
          else
            {
              setState(() {
                userLocationController.text = documentSnapshot.get("location");
              })
            }
        });
  }

  late TextEditingController userLocationController = TextEditingController();

  void initState() {
    getUserInfofromdb();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          Expanded(
              flex: 2,
              child: ListView(children: <Widget>[
                Container(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                      Expanded(
                          child: Container(
                        width: 450,
                        height: 300,
                        margin: const EdgeInsets.all(50.0),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: lightblack, width: 7)),
                        child: ListView(children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Text.rich(
                            TextSpan(
                              style: TextStyle(
                                fontSize: 17,
                              ),
                              children: [
                                WidgetSpan(
                                    child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(19, 10, 15, 0),
                                  child: Icon(Icons.home),
                                )),
                                TextSpan(
                                    text: 'Home',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    )),
                                WidgetSpan(
                                  child: TextLink(
                                      text: " Use Your Home Address ",
                                      align: Alignment.center,
                                      press: () => {
                                            Alert(
                                                context: context,
                                                title: "Enter home address",
                                                content: Column(
                                                  children: <Widget>[
                                                    RoundTextField(
                                                      autofocus: false,
                                                      preicon: Icon(
                                                          Icons.location_pin),
                                                      text: "Location",
                                                      control:
                                                          userLocationController,
                                                    ),
                                                  ],
                                                ),
                                                buttons: [
                                                  DialogButton(
                                                    onPressed: () {
                                                      if (!(g == 0)) {
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder: (BuildContext
                                                                        context) =>
                                                                    CheckOutDelivery()));
                                                      } else {
                                                        showDialog<String>(
                                                          context: context,
                                                          builder: (BuildContext
                                                                  context) =>
                                                              AlertDialog(
                                                            title: const Text(
                                                                'Your Cart Is Empty'),
                                                            content: const Text(
                                                                'Please Add Items to cart',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .greenAccent)),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                child: Text(
                                                                    'Browse Products',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black)),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .push(MaterialPageRoute(
                                                                          builder: (BuildContext context) =>
                                                                              HomePage()));
                                                                },
                                                              ),
                                                              TextButton(
                                                                child: Text(
                                                                    'Cancel',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black)),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      }
                                                      
                                                    },
                                                    child: Text(
                                                      "Add",
                                                      style: TextStyle(
                                                          color: white,
                                                          fontSize: 20),
                                                    ),
                                                    color: lightblack,
                                                  ),
                                                  DialogButton(
                                                    onPressed: () {
                                                      if (!(g == 0)) {
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder: (BuildContext
                                                                        context) =>
                                                                    CheckOutDelivery()));
                                                      } else {
                                                        showDialog<String>(
                                                          context: context,
                                                          builder: (BuildContext
                                                                  context) =>
                                                              AlertDialog(
                                                            title: const Text(
                                                                'Your Cart Is Empty'),
                                                            content: const Text(
                                                                'Please Add Items to cart',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .greenAccent)),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                child: Text(
                                                                    'Browse Products',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black)),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .push(MaterialPageRoute(
                                                                          builder: (BuildContext context) =>
                                                                              HomePage()));
                                                                },
                                                              ),
                                                              TextButton(
                                                                child: Text(
                                                                    'Cancel',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black)),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      }
                                                      
                                                    },
                                                    child: Text(
                                                      "Already Added",
                                                      style: TextStyle(
                                                          color: white,
                                                          fontSize: 20),
                                                    ),
                                                    color: lightblack,
                                                  )
                                                ]).show(),
                                          }),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: 20,
                            thickness: 2.5,
                            indent: 30,
                            endIndent: 30,
                            color: lightblack,
                          ),
                          Text.rich(
                            TextSpan(
                              style: TextStyle(
                                fontSize: 17,
                              ),
                              children: [
                                WidgetSpan(
                                    child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(19, 10, 15, 0),
                                  child: Icon(Icons.work),
                                )),
                                TextSpan(
                                    text: 'Work',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    )),
                                WidgetSpan(
                                  child: TextLink(
                                      text: " Use Your Work Address ",
                                      align: Alignment.center,
                                      press: () => {
                                            Alert(
                                                context: context,
                                                title: "Enter Work address",
                                                content: Column(
                                                  children: <Widget>[
                                                    RoundTextField(
                                                      autofocus: false,
                                                      preicon: Icon(
                                                          Icons.location_pin),
                                                      text: "Location",
                                                      control:
                                                          userLocationController,
                                                    ),
                                                  ],
                                                ),
                                                buttons: [
                                                  DialogButton(
                                                    onPressed: () {
                                                      if (!(g == 0)) {
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder: (BuildContext
                                                                        context) =>
                                                                    CheckOutDelivery()));
                                                      } else {
                                                        showDialog<String>(
                                                          context: context,
                                                          builder: (BuildContext
                                                                  context) =>
                                                              AlertDialog(
                                                            title: const Text(
                                                                'Your Cart Is Empty'),
                                                            content: const Text(
                                                                'Please Add Items to cart',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .greenAccent)),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                child: Text(
                                                                    'Browse Products',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black)),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .push(MaterialPageRoute(
                                                                          builder: (BuildContext context) =>
                                                                              HomePage()));
                                                                },
                                                              ),
                                                              TextButton(
                                                                child: Text(
                                                                    'Cancel',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black)),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      }
                                                      
                                                    },
                                                    child: Text(
                                                      "Add",
                                                      style: TextStyle(
                                                          color: white,
                                                          fontSize: 20),
                                                    ),
                                                    color: lightblack,
                                                  ),
                                                  DialogButton(
                                                    onPressed: () {
                                                      if (!(g == 0)) {
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder: (BuildContext
                                                                        context) =>
                                                                    CheckOutDelivery()));
                                                      } else {
                                                        showDialog<String>(
                                                          context: context,
                                                          builder: (BuildContext
                                                                  context) =>
                                                              AlertDialog(
                                                            title: const Text(
                                                                'Your Cart Is Empty'),
                                                            content: const Text(
                                                                'Please Add Items to cart',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .greenAccent)),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                child: Text(
                                                                    'Browse Products',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black)),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .push(MaterialPageRoute(
                                                                          builder: (BuildContext context) =>
                                                                              HomePage()));
                                                                },
                                                              ),
                                                              TextButton(
                                                                child: Text(
                                                                    'Cancel',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black)),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      }
                                                      
                                                    },
                                                    child: Text(
                                                      "Already Added",
                                                      style: TextStyle(
                                                          color: white,
                                                          fontSize: 20),
                                                    ),
                                                    color: lightblack,
                                                  )
                                                ]).show(),
                                          }),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: 20,
                            thickness: 2.5,
                            indent: 30,
                            endIndent: 30,
                            color: lightblack,
                          ),
                          Text.rich(
                            TextSpan(
                              style: TextStyle(
                                fontSize: 17,
                              ),
                              children: [
                                WidgetSpan(
                                    child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(19, 10, 15, 0),
                                  child: Icon(Icons.home),
                                )),
                                TextSpan(
                                    text: 'Other Address',
                                    style: TextStyle(
                                      fontSize: 15.5,
                                      fontWeight: FontWeight.bold,
                                    )),
                                WidgetSpan(
                                  child: TextLink(
                                    text: " Add Address ",
                                    align: Alignment.center,
                                    press: () => {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  FirstDelivaryPage()))
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: 15,
                            thickness: 2.5,
                            indent: 30,
                            endIndent: 30,
                            color: lightblack,
                          ),
                        ]),
                      ))
                    ]))
              ])),
        ],
      ),
    );
  }
}