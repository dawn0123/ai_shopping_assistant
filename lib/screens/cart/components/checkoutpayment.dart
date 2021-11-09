// ignore: must_be_immutable
import 'package:aishop/screens/homepage/homepage.dart';
import 'package:aishop/screens/past_purchases/pastpurchase.dart';
import 'package:aishop/services/historytracker.dart';
import 'package:aishop/services/orders.dart';
import 'package:aishop/styles/textlink.dart';
import 'package:aishop/styles/theme.dart';
import 'package:aishop/utils/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../checkout/tabs.dart';

int account = 0;

Future<double> getTotal() async {
  double a = 0;
  await FirebaseFirestore.instance
      .collection("Users")
      .doc(uid)
      .get()
      .then((value) {
    a = value.get('total');
    account = value.get('account');
  });
  return a;
}

class CheckOutPayment extends StatefulWidget {
  @override
  State<CheckOutPayment> createState() => _CheckOutPaymentState();
}

class _CheckOutPaymentState extends State<CheckOutPayment> {
  double total = 0;
  String deliveryMethod = "";
  double deliverycost = 70;
  double subttotal = 0;

  @override
  void initState() {
    getTotal().then((value) {
      setState(() {
        subttotal = value;
        if (subttotal == 0)
          deliverycost = 0;
        else
          deliverycost = deliveryCost!;
        total = subttotal + deliverycost;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getTotal().then((value) {
      setState(() {
        subttotal = value;
        if (subttotal == 0)
          deliverycost = 0;
        else
          deliverycost = deliveryCost!;
        total = subttotal + deliverycost;
      });
    });
    return Scaffold(
        floatingActionButton: null,
        body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('Users').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              return Center(
                  child: Row(
                children: <Widget>[
                  // Expanded( child: ListView(children: <Widget>[
                  //     SizedBox(height: 30),
                  //     Container( child: Center(
                  //         child: TextLink( text: 'Past Transactions', align: Alignment.center,
                  //           press: () => {
                  //             Navigator.of(context).push(MaterialPageRoute( builder: (BuildContext context) => PastPurchase()))
                  //           },
                  //         ),
                  //       ),
                  //       width: double.infinity,
                  //       height: 50,
                  //     ),
                  //     Divider( height: 10, thickness: 2, indent: 10, endIndent: 10, color: lightblack,),
                  //   ]),
                  // ),
                  Expanded(
                    flex: 2,
                    child: ListView(children: <Widget>[
                      Container(
                        width: 250,
                        height: 70,
                        margin: const EdgeInsets.fromLTRB(50.0, 50, 50, 0),
                        padding: const EdgeInsets.all(20.0),
                        decoration:
                            BoxDecoration(border: Border.all(color: accent)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              flex: 5,
                              child: Text("Amount Available: ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: "Inria Serif",
                                      color: lightblack,
                                      fontWeight: FontWeight.w300)),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text("R",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: "Inria Serif",
                                      color: lightblack,
                                      fontWeight: FontWeight.w100)),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                child: Text(account.toStringAsFixed(2),
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: "Inria Serif",
                                      color: lightblack,
                                    )),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                            Expanded(
                              child: Container(
                                  width: 400,
                                  height: 300,
                                  margin: const EdgeInsets.all(50.0),
                                  padding: const EdgeInsets.all(50.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: lightblack)),
                                  child: new Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Expanded(
                                              flex: 5,
                                              child: Text("Order subtotal:",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontFamily: "Inria Serif",
                                                      color: lightblack,
                                                      fontWeight:
                                                          FontWeight.w100)),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Text("R",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontFamily: "Inria Serif",
                                                      color: lightblack,
                                                      fontWeight:
                                                          FontWeight.w100)),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                child: Text(
                                                    subttotal
                                                        .toStringAsFixed(2),
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontFamily: "Inria Serif",
                                                      color: lightblack,
                                                    )),
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Expanded(
                                              flex: 5,
                                              child: Text("Delivery:",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontFamily: "Inria Serif",
                                                      color: lightblack,
                                                      fontWeight:
                                                          FontWeight.w100)),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Text("R",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontFamily: "Inria Serif",
                                                      color: lightblack,
                                                      fontWeight:
                                                          FontWeight.w100)),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                  deliverycost
                                                      .toStringAsFixed(2),
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontFamily: "Inria Serif",
                                                      color: lightblack)),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                  child: Text("Promo Code: ",
                                                      style: new TextStyle(
                                                          color: lightblack,
                                                          fontFamily:
                                                              "Inria Serif",
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 18.0))),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                  width: 350,
                                                  height: 50,
                                                  child: TextFormField(
                                                    decoration: InputDecoration(
                                                      fillColor: black,
                                                      hintText:
                                                          'e.g. FirstTimePromo',
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                                color:
                                                                    lightblack,
                                                                width: 2.0),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                                color:
                                                                    lightblack,
                                                                width: 2.0),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                      ),
                                                    ),
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'Nunito Sans',
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  )),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Divider(
                                          height: 20,
                                          thickness: 1,
                                          indent: 20,
                                          endIndent: 20,
                                          color: lightblack,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Expanded(
                                              flex: 5,
                                              child: Text("Total:",
                                                  style: TextStyle(
                                                      fontSize: 25,
                                                      fontFamily: "Inria Serif",
                                                      color: lightblack,
                                                      fontWeight:
                                                          FontWeight.w100)),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Text("R",
                                                  style: TextStyle(
                                                      fontSize: 25,
                                                      fontFamily: "Inria Serif",
                                                      color: lightblack,
                                                      fontWeight:
                                                          FontWeight.w100)),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                  total.toStringAsFixed(2),
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontFamily: "Inria Serif",
                                                      color: lightblack)),
                                            )
                                          ],
                                        ),
                                      ])),
                            ),
                          ])),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              //====================================================================================row

                              children: [
                            Container(
                              width: 250,
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
                                    side:
                                        BorderSide(color: lightblack, width: 2),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                  ),
                                  onPressed: () {
                                    addToPurchases();
                                    // addToOrders();
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                HomePage()));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "Your purchase was successful!")));
                                  },
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
