// ignore: must_be_immutable
import 'package:aishop/screens/cart/components/order_review.dart';
import 'package:aishop/screens/delivery/checkoutdelivery.dart';
import 'package:aishop/screens/homepage/homepage.dart';
import 'package:aishop/screens/past_purchases/pastpurchase.dart';
import 'package:aishop/services/historytracker.dart';
import 'package:aishop/styles/textlink.dart';
import 'package:aishop/styles/theme.dart';
import 'package:aishop/widgets/appbar/appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CheckOutPayment extends StatelessWidget {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: null,
        appBar: MyAppBar(
          title: Text(
            "Delivery Method",
          ),
          context: context,
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('Users').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              return Container(
                  child: Row(
                children: <Widget>[
                  Expanded(
                      child: Column(
                    children: <Widget>[
                      Expanded(
                        child: ListView(children: <Widget>[
                          SizedBox(
                            height: 30,
                          ),
                          // Container(
                          //   child: Center(
                          //     child: TextLink(
                          //       text: 'Load Credits',
                          //       align: Alignment.center,
                          //       press: () => {},
                          //     ),
                          //   ),
                          //   width: double.infinity,
                          //   height: 50,
                          // ),
                          // Divider(
                          //   height: 10,
                          //   thickness: 2,
                          //   indent: 10,
                          //   endIndent: 10,
                          //   color: lightblack,
                          // ),
                          Container(
                            child: Center(
                              child: TextLink(
                                text: 'Past Transactions',
                                align: Alignment.center,
                                press: () => {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          PastPurchase()))
                                },
                              ),
                            ),
                            width: double.infinity,
                            height: 50,
                          ),
                          Divider(
                            height: 10,
                            thickness: 2,
                            indent: 10,
                            endIndent: 10,
                            color: lightblack,
                          ),
                        ]),
                      ),
                    ],
                  )),
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
                                  height: 360,
                                  margin: const EdgeInsets.all(50.0),
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: lightblack)),
                                  child: new Column(children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 0.0,
                                          top: 8.0,
                                          bottom: 2.0,
                                          right: 100.0),
                                      child: Text(
                                          "Order Subtotal           R$g",
                                          style: new TextStyle(
                                              color: lightblack,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 18.0)),
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(
                                            left: 0.0,
                                            top: 12.0,
                                            bottom: 0.0,
                                            right: 150.0),
                                        child: Text(
                                            "Delivery        R" + n.toString(),
                                            style: new TextStyle(
                                                color: lightblack,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 18.0))),
                                    Container(
                                        margin: EdgeInsets.only(
                                            left: 10.0,
                                            top: 12.0,
                                            bottom: 0.0,
                                            right: 200.0),
                                        child: Text("Promo Code ",
                                            style: new TextStyle(
                                                color: lightblack,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 18.0))),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                        width: 350,
                                        height: 50,
                                        margin: EdgeInsets.only(
                                            left: 30.0,
                                            top: 0.0,
                                            bottom: 0.0,
                                            right: 100.0),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            fillColor: black,
                                            hintText: 'e.g. FirstTimePromo',
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: lightblack,
                                                  width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: lightblack,
                                                  width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                          ),
                                          style: TextStyle(
                                              fontFamily: 'Nunito Sans',
                                              fontWeight: FontWeight.w300),
                                        )),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Divider(
                                      height: 20,
                                      thickness: 2,
                                      indent: 20,
                                      endIndent: 20,
                                      color: lightblack,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 0.0,
                                          top: 8.0,
                                          bottom: 2.0,
                                          right: 150.0),
                                      child: Text(
                                          "TOTAL         R" +
                                              (g + n).toString(),
                                          style: new TextStyle(
                                              color: lightblack,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 18.0)),
                                    ),
                                  ])),
                            ),
                          ])),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              //====================================================================================row

                              children: [
                            Container(
                              width: 250,
                              height: 50,
                              margin: EdgeInsets.only(
                                  left: 0.0,
                                  top: 0.0,
                                  bottom: 0.0,
                                  right: 20.0),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    onPrimary: lightblack, // background
                                    primary: lightblack,
                                    textStyle: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Nunito Sans',
                                      fontWeight: FontWeight.w300,
                                    ),
                                    side:
                                        BorderSide(color: lightblack, width: 2),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                  ),
                                  onPressed: () => showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: const Text('Purchase'),
                                          content: const Text(
                                              'Your purchase was  succesful ',
                                              style: TextStyle(
                                                  color: Colors.black54)),
                                          actions: <Widget>[
                                            ElevatedButton(
                                              child: Text('OK',
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.black,
                                              ),
                                              onPressed: () {
                                                addToPurchases();
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            HomePage()));
                                              },
                                            ),
                                            TextButton(
                                              child: Text('Cancel',
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                  child: Text("Purchase",
                                      style: new TextStyle(
                                          color: lightestgrey,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 20.0))),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ]))
                    ]),
                  ),
                ],
              ));
            }));
  }
}