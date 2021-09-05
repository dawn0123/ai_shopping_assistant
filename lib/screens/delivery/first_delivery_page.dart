import 'package:aishop/screens/cart/components/order_review.dart';
import 'package:aishop/screens/delivery/checkoutdelivery.dart';
import 'package:aishop/screens/homepage/homepage.dart';
import 'package:aishop/styles/round_textfield.dart';
import 'package:aishop/styles/textlink.dart';
import 'package:aishop/styles/theme.dart';
import 'package:aishop/utils/authentication.dart';
import 'package:aishop/widgets/appbar/appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class FirstDelivaryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FirstDelivaryPage();
  }
}

class _FirstDelivaryPage extends State<FirstDelivaryPage> {
  late TextEditingController userLocationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text(
          'Add Address',
          style: TextStyle(color: white),
        ),
        context: context,
      ),
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
                        height: 400,
                        margin: const EdgeInsets.all(50.0),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: lightblack, width: 7)),
                        child: ListView(children: <Widget>[
                          SizedBox(
                            height: 40,
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
                                                title: "Enter Home address",
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
                            height: 10,
                            thickness: 2,
                            indent: 10,
                            endIndent: 10,
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
                            height: 10,
                            thickness: 2,
                            indent: 10,
                            endIndent: 10,
                            color: lightblack,
                          ),
                        ]),
                      ))
                    ]))
              ])),
          Expanded(
            flex: 2,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: 0.0, top: 0.0, bottom: 0.0, right: 400.0),
                  child: Text("Name",
                      style: new TextStyle(
                          color: lightblack,
                          fontWeight: FontWeight.normal,
                          fontSize: 16.0)),
                ),
                Container(
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //====================================================================================row

                        children: [
                      Container(
                          width: 450,
                          height: 50,
                          child: TextFormField(
                            decoration: InputDecoration(
                              fillColor: black,
                              hintText: 'new Address',
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: lightblack, width: 2.0),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: lightblack, width: 2.0),
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            style: TextStyle(
                                fontFamily: 'Nunito Sans',
                                fontWeight: FontWeight.w300),
                          )),
                      //====================================================================================row
                    ]
                        //====================================================================================rowEnded
                        )),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: 0.0, top: 0.0, bottom: 0.0, right: 350.0),
                  child: Text("Street Address",
                      style: new TextStyle(
                          color: lightblack,
                          fontWeight: FontWeight.normal,
                          fontSize: 16.0)),
                ),
                Container(
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //====================================================================================row
                        children: [
                      Container(
                          width: 450,
                          height: 50,
                          child: TextFormField(
                            decoration: InputDecoration(
                              fillColor: black,
                              hintText: 'Street and number / P.O. box',
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: lightblack, width: 2.0),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: lightblack, width: 2.0),
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            style: TextStyle(
                                fontFamily: 'Nunito Sans',
                                fontWeight: FontWeight.w300),
                          )),
                      //====================================================================================row
                    ]
                        //====================================================================================rowEnded
                        )),
                SizedBox(
                  height: 10,
                ),
                Container(
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //====================================================================================row
                        children: [
                      Container(
                          width: 450,
                          height: 50,
                          child: TextFormField(
                            decoration: InputDecoration(
                              fillColor: black,
                              hintText:
                                  'Apartment, suit, unit, building, floor etc',
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: lightblack, width: 2.0),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: lightblack, width: 2.0),
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            style: TextStyle(
                                fontFamily: 'Nunito Sans',
                                fontWeight: FontWeight.w300),
                          )),
                      //====================================================================================row
                    ]
                        //====================================================================================rowEnded
                        )),
                Container(
                  margin: EdgeInsets.only(
                      left: 0.0, top: 0.0, bottom: 0.0, right: 400.0),
                  child: Text("City",
                      style: new TextStyle(
                          color: lightblack,
                          fontWeight: FontWeight.normal,
                          fontSize: 16.0)),
                ),
                Container(
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //====================================================================================row
                        children: [
                      Container(
                          width: 450,
                          height: 50,
                          child: TextFormField(
                            decoration: InputDecoration(
                              fillColor: black,
                              hintText: ' ',
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: lightblack, width: 2.0),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: lightblack, width: 2.0),
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            style: TextStyle(
                                fontFamily: 'Nunito Sans',
                                fontWeight: FontWeight.w300),
                          )),
                      //====================================================================================row
                    ]
                        //====================================================================================rowEnded
                        )),
                SizedBox(
                  height: 15,
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: 0.0, top: 0.0, bottom: 0.0, right: 400.0),
                  child: Text("Province",
                      style: new TextStyle(
                          color: lightblack,
                          fontWeight: FontWeight.normal,
                          fontSize: 16.0)),
                ),
                Container(
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //====================================================================================row
                        children: [
                      Container(
                          width: 450,
                          height: 50,
                          child: TextFormField(
                            decoration: InputDecoration(
                              fillColor: black,
                              hintText: ' ',
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: lightblack, width: 2.0),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: lightblack, width: 2.0),
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            style: TextStyle(
                                fontFamily: 'Nunito Sans',
                                fontWeight: FontWeight.w300),
                          )),
                      //====================================================================================row
                    ]
                        //====================================================================================rowEnded
                        )),
                SizedBox(
                  height: 15,
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: 0.0, top: 0.0, bottom: 0.0, right: 400.0),
                  child: Text("Zip Code",
                      style: new TextStyle(
                          color: lightblack,
                          fontWeight: FontWeight.normal,
                          fontSize: 16.0)),
                ),
                Container(
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //====================================================================================row
                        children: [
                      Container(
                          width: 450,
                          height: 50,
                          child: TextFormField(
                            decoration: InputDecoration(
                              fillColor: white,
                              hintText: '',
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: lightblack, width: 2.0),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: lightblack, width: 2.0),
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            style: TextStyle(
                                fontFamily: 'Nunito Sans',
                                fontWeight: FontWeight.w300),
                          )),
                      //====================================================================================row
                    ]
                        //====================================================================================rowEnded
                        )),
                SizedBox(
                  height: 15,
                ),
                Divider(
                  height: 20,
                  thickness: 2,
                  indent: 0,
                  endIndent: 20,
                  color: lightblack,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //====================================================================================row

                        children: [
                      Container(
                        width: 300,
                        height: 50,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              onPrimary: lightblack, // background
                              primary: lightblack,
                              textStyle: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Nunito Sans',
                                fontWeight: FontWeight.w300,
                              ),
                              side: BorderSide(color: lightblack, width: 2),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100)),
                            ),
                            onPressed: () => showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text('Save Address'),
                                    content: const Text(
                                        'Your new address is succesfully added',
                                        style: TextStyle(
                                            color: Colors.greenAccent)),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('OK',
                                            style:
                                                TextStyle(color: Colors.black)),
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          CheckOutDelivery()));
                                        },
                                      ),
                                      TextButton(
                                        child: Text('Cancel',
                                            style:
                                                TextStyle(color: Colors.black)),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                            child: Text("Save Address",
                                style: new TextStyle(
                                    color: lightestgrey,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 20.0))),
                      ),
                    ])),
                SizedBox(
                  height: 20,
                ),
                Container(
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //====================================================================================row

                        children: [
                      Container(
                        width: 300,
                        height: 50,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              onPrimary: lightblack, // background
                              primary: white,
                              textStyle: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Nunito Sans',
                                fontWeight: FontWeight.w300,
                              ),
                              side: BorderSide(color: lightblack, width: 2),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100)),
                            ),
                            onPressed: () => showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text('Discard'),
                                    content: const Text(
                                        'Your new address is not added ',
                                        style:
                                            TextStyle(color: Colors.redAccent)),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('OK',
                                            style:
                                                TextStyle(color: Colors.black)),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                            child: Text("Discard",
                                style: new TextStyle(
                                    color: lightblack,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 20.0))),
                      ),
                    ])),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

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

  void initState() {
    getUserInfofromdb();
    super.initState();
  }
}