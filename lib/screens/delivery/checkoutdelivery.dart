import 'package:aishop/screens/cart/components/checkoutpayment.dart';
import 'package:aishop/screens/checkout/tabs.dart';
import 'package:aishop/styles/theme.dart';
import 'package:aishop/utils/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CheckoutDelivery extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewDeliveryPage();
  }
}

class _NewDeliveryPage extends State<CheckoutDelivery> {
  late bool a;
  late bool b;
  late bool c;
  late bool d;
  late bool color;

  @override
  void initState() {
    super.initState();
    // print(index);
    a = true;
    b = false;
    c = false;
    d = false;
    color = false;
    if (index == 0) {
      a = true;
      b = false;
      c = false;
      d = false;
    } else if (index == 1) {
      a = false;
      b = true;
      c = false;
      d = false;
    } else if (index == 2) {
      a = false;
      b = false;
      c = true;
      d = false;
    } else if (index == 3) {
      a = false;
      b = false;
      c = false;
      d = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
      child: Center(
        child: ListView(children: [
          // !a
          //     ?
          Container(
            width: size.width * 0.5,
            height: 180,
            padding: EdgeInsets.symmetric(vertical: 25),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                // backgroundColor: MaterialStateProperty.all(Colors.red),
                primary: white,
                side: BorderSide(color: lightblack, width: 2),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
              ),
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('Users')
                    .doc(uid)
                    .update(
                    {'default delivery': "Standard Delivery",
                      "delivery cost" : 70,
                      "delivery index" : 0
                    });

                setState(() {
                  a = true;
                  b = false;
                  c = false;
                  d = false;
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Row(children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Standard Delivery",
                            style: new TextStyle(
                                color: lightblack,
                                fontFamily: "Inria Serif",
                                fontWeight: FontWeight.w300,
                                fontSize: 20)),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                              "Estimated delivery in 4 - 7 business days",
                              style: new TextStyle(
                                  color: lighterblack,
                                  fontFamily: "Nunito Sans",
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15.0)),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("R70",
                          style: new TextStyle(
                              color: lightblack,
                              fontFamily: "Inria Serif",
                              fontWeight: FontWeight.w300,
                              fontSize: 28.0)),
                    ),
                  ),
                ]),
              ),
            ),
          ),
          // : Container(
          //     width: size.width * 0.5,
          //     height: 180,
          //     padding: EdgeInsets.symmetric(vertical: 25),
          //     child: ElevatedButton(
          //       style: ElevatedButton.styleFrom(
          //         primary: lightblack,
          //         side: BorderSide(color: black, width: 2),
          //         shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(100)),
          //       ),
          //       onPressed: () {},
          //       child: Padding(
          //         padding: const EdgeInsets.all(25.0),
          //         child: Row(children: <Widget>[
          //           Expanded(
          //             flex: 3,
          //             child: Column(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Text("Standard Delivery",
          //                     style: new TextStyle(
          //                         color: white,
          //                         fontFamily: "Inria Serif",
          //                         fontWeight: FontWeight.w300,
          //                         fontSize: 25.0)),
          //                 Padding(
          //                   padding: const EdgeInsets.all(5.0),
          //                   child: Text(
          //                       "Estimated delivery in 4 - 7 business days",
          //                       style: new TextStyle(
          //                           color: lightestgrey,
          //                           fontFamily: "Nunito Sans",
          //                           fontWeight: FontWeight.normal,
          //                           fontSize: 15.0)),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           Expanded(
          //             flex: 1,
          //             child: Padding(
          //               padding: const EdgeInsets.all(10.0),
          //               child: Text("R70",
          //                   style: new TextStyle(
          //                       color: white,
          //                       fontFamily: "Inria Serif",
          //                       fontWeight: FontWeight.w300,
          //                       fontSize: 28.0)),
          //             ),
          //           ),
          //         ]),
          //       ),
          //     ),
          //   ),
          // !b
          //     ?
          Container(
            width: size.width * 0.5,
            height: 180,
            padding: EdgeInsets.symmetric(vertical: 25),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: white,
                side: BorderSide(color: lightblack, width: 2),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
              ),
              onPressed: () async {
                // await FirebaseFirestore.instance
                //     .collection('Users')
                //     .doc(uid)
                //     .update(
                //     {'default delivery': "Next Business Day Delivery",
                //       "delivery cost" : 250,
                //       "delivery index" : 1
                //     });
                // setState(() {
                //   a = false;
                //   b = true;
                //   c = false;
                //   d = false;
                // });
              },
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Row(children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Next Business Day Delivery",
                            overflow: TextOverflow.fade,
                            softWrap: false,
                            maxLines: 1,
                            style: new TextStyle(
                                color: lightblack,
                                fontFamily: "Inria Serif",
                                fontWeight: FontWeight.w300,
                                fontSize: 25.0)),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text("Estimated delivery tomorrow",
                              overflow: TextOverflow.fade,
                              softWrap: false,
                              maxLines: 1,
                              style: new TextStyle(
                                  color: lighterblack,
                                  fontFamily: "Nunito Sans",
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15.0)),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("R100",
                          style: new TextStyle(
                              color: lightblack,
                              fontFamily: "Inria Serif",
                              fontWeight: FontWeight.w300,
                              fontSize: 28.0)),
                    ),
                  ),
                ]),
              ),
            ),
          ),
          // : Container(
          //     width: size.width * 0.5,
          //     height: 180,
          //     padding: EdgeInsets.symmetric(vertical: 25),
          //     child: ElevatedButton(
          //       style: ElevatedButton.styleFrom(
          //         primary: lightblack,
          //         side: BorderSide(color: black, width: 2),
          //         shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(100)),
          //       ),
          //       onPressed: () {},
          //       child: Padding(
          //         padding: const EdgeInsets.all(25.0),
          //         child: Row(children: <Widget>[
          //           Expanded(
          //             flex: 3,
          //             child: Column(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Text("Next Business Day Delivery",
          //                     overflow: TextOverflow.fade,
          //                     softWrap: false,
          //                     maxLines: 1,
          //                     style: new TextStyle(
          //                         color: white,
          //                         fontFamily: "Inria Serif",
          //                         fontWeight: FontWeight.w300,
          //                         fontSize: 25.0)),
          //                 Padding(
          //                   padding: const EdgeInsets.all(5.0),
          //                   child: Text("Estimated delivery tomorrow",
          //                       overflow: TextOverflow.fade,
          //                       softWrap: false,
          //                       maxLines: 1,
          //                       style: new TextStyle(
          //                           color: lightestgrey,
          //                           fontFamily: "Nunito Sans",
          //                           fontWeight: FontWeight.w100,
          //                           fontSize: 15.0)),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           Expanded(
          //             flex: 1,
          //             child: Padding(
          //               padding: const EdgeInsets.all(10.0),
          //               child: Text("R100",
          //                   style: new TextStyle(
          //                       color: white,
          //                       fontFamily: "Inria Serif",
          //                       fontWeight: FontWeight.w300,
          //                       fontSize: 28.0)),
          //             ),
          //           ),
          //         ]),
          //       ),
          //     ),
          //   ),
          // !c
          //     ?
          Container(
            width: size.width * 0.5,
            height: 180,
            padding: EdgeInsets.symmetric(vertical: 25),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: white,
                side: BorderSide(color: lightblack, width: 2),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
              ),
              onPressed: () async {
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (BuildContext context) => CheckOutPayment()));
                // await FirebaseFirestore.instance
                //     .collection('Users')
                //     .doc(uid)
                //     .update(
                //     {'default delivery': "2nd - 3rd Business Day Delivery",
                //       "delivery cost" : 200,
                //       "delivery index" : 2
                //     });
                // setState(() {
                //   a = false;
                //   b = false;
                //   c = true;
                //   d = false;
                // });
              },
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Saturday Delivery",
                                overflow: TextOverflow.fade,
                                softWrap: false,
                                maxLines: 1,
                                style: new TextStyle(
                                    color: lightblack,
                                    fontFamily: "Inria Serif",
                                    fontWeight: FontWeight.w300,
                                    fontSize: 25.0)),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text("Standard Delivery",
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                  maxLines: 1,
                                  style: new TextStyle(
                                      color: lighterblack,
                                      fontFamily: "Nunito Sans",
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15.0)),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text("R100",
                              style: new TextStyle(
                                  color: lightblack,
                                  fontFamily: "Inria Serif",
                                  fontWeight: FontWeight.w300,
                                  fontSize: 28.0)),
                        ),
                      ),
                    ]),
              ),
            ),
          )
          // : Container(
          //     width: size.width * 0.5,
          //     height: 180,
          //     padding: EdgeInsets.symmetric(vertical: 25),
          //     child: ElevatedButton(
          //       style: ElevatedButton.styleFrom(
          //         primary: lightblack,
          //         side: BorderSide(color: black, width: 2),
          //         shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(100)),
          //       ),
          //       onPressed: () {},
          //       child: Padding(
          //         padding: const EdgeInsets.all(25.0),
          //         child: Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: <Widget>[
          //               Expanded(
          //                 flex: 3,
          //                 child: Column(
          //                   mainAxisAlignment: MainAxisAlignment.center,
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     Text("Sunday Delivery",
          //                         overflow: TextOverflow.fade,
          //                         softWrap: false,
          //                         maxLines: 1,
          //                         style: new TextStyle(
          //                             color: white,
          //                             fontFamily: "Inria Serif",
          //                             fontWeight: FontWeight.w300,
          //                             fontSize: 25.0)),
          //                     Padding(
          //                       padding: const EdgeInsets.all(5.0),
          //                       child: Text("Standard Delivery",
          //                           overflow: TextOverflow.fade,
          //                           softWrap: false,
          //                           maxLines: 1,
          //                           style: new TextStyle(
          //                               color: lightestgrey,
          //                               fontFamily: "Nunito Sans",
          //                               fontWeight: FontWeight.normal,
          //                               fontSize: 15.0)),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //               Expanded(
          //                 flex: 1,
          //                 child: Padding(
          //                   padding: const EdgeInsets.all(10.0),
          //                   child: Text("R100",
          //                       style: new TextStyle(
          //                           color: white,
          //                           fontFamily: "Inria Serif",
          //                           fontWeight: FontWeight.w300,
          //                           fontSize: 28.0)),
          //                 ),
          //               ),
          //             ]),
          //       ),
          //     ),
          //   ),
        ]),
      ),
    ));
  }
}
