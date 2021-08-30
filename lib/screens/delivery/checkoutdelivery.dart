import 'package:aishop/screens/cart/components/checkoutpayment.dart';
import 'package:aishop/styles/theme.dart';
import 'package:aishop/widgets/appbar/appbar.dart';
import 'package:flutter/material.dart';

var n = 0;

class CheckOutDelivery extends StatefulWidget {
  //User _user = FirebaseAuth.instance.currentUser!;
  @override
  _CheckOutDelivery createState() => _CheckOutDelivery();
}

class _CheckOutDelivery extends State<CheckOutDelivery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: null,
        appBar: MyAppBar(
          title: Text(
            "Check Out Delivery Payment",
          ),
          context: context,
        ),
        body: Container(
            child: ListView(children: <Widget>[
          SizedBox(
            height: 45,
          ),
          Container(
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //====================================================================================row

                children: [
                  Container(
                    width: 500,
                    height: 150,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        onPrimary: black, // background
                        primary: black,
                        textStyle: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Nunito Sans',
                          fontWeight: FontWeight.w300,
                        ),
                        side: BorderSide(color: lightblack, width: 2),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100)),
                      ),
                      onPressed: () {
                        setState(() {
                          n = 70;
                        });
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                CheckOutPayment()));
                      },
                      child: new Padding(
                          padding: EdgeInsets.fromLTRB(5, 25, 3, 0),
                          child: Column(children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                  left: 5.0,
                                  top: 8.0,
                                  bottom: 2.0,
                                  right: 300.0),
                              child: Text("Standard Delivery",
                                  style: new TextStyle(
                                      color: white,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 18.0)),
                            ),
                            Container(
                                margin: EdgeInsets.only(
                                    left: 0.0,
                                    top: 12.0,
                                    bottom: 0.0,
                                    right: 200.0),
                                child: Text(
                                    "Estimated delivery in 4 - 7 business days",
                                    style: new TextStyle(
                                        color: white,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12.0))),
                            Container(
                                margin: EdgeInsets.only(
                                    left: 400.0,
                                    top: 0.0,
                                    bottom: 12.0,
                                    right: 0.0),
                                child: Text("R70",
                                    style: new TextStyle(
                                        color: white,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 20.0))),
                          ])),
                    ),
                  )
                ]),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //====================================================================================row

                  children: [
                Container(
                    width: 500,
                    height: 150,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        onPrimary: black, // background
                        primary: black,
                        textStyle: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Nunito Sans',
                          fontWeight: FontWeight.w300,
                        ),
                        side: BorderSide(color: lightblack, width: 2),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100)),
                      ),
                      onPressed: () {
                        setState(() {
                          n = 250;
                        });
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                CheckOutPayment()));
                      },
                      child: new Padding(
                          padding: EdgeInsets.fromLTRB(5, 25, 3, 0),
                          child: Column(children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                  left: 5.0,
                                  top: 8.0,
                                  bottom: 2.0,
                                  right: 250.0),
                              child: Text("Next Business Day Delivery",
                                  style: new TextStyle(
                                      color: white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15.0)),
                            ),
                            Container(
                                margin: EdgeInsets.only(
                                    left: 0.0,
                                    top: 12.0,
                                    bottom: 0.0,
                                    right: 250.0),
                                child: Text("Estimated delivery tomorrow",
                                    style: new TextStyle(
                                        color: white,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12.0))),
                            Container(
                                margin: EdgeInsets.only(
                                    left: 400.0,
                                    top: 0.0,
                                    bottom: 12.0,
                                    right: 0.0),
                                child: Text("R250",
                                    style: new TextStyle(
                                        color: white,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 20.0))),
                          ])),
                    ))
              ])),
          SizedBox(
            height: 20,
          ),
          Container(
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //====================================================================================row

                  children: [
                Container(
                  width: 500,
                  height: 150,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      onPrimary: black, // background
                      primary: black,
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Nunito Sans',
                        fontWeight: FontWeight.w300,
                      ),
                      side: BorderSide(color: lightblack, width: 2),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                    ),
                    onPressed: () {
                      setState(() {
                        n = 200;
                      });
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              CheckOutPayment()));
                    },
                    child: new Padding(
                        padding: EdgeInsets.fromLTRB(5, 25, 3, 0),
                        child: Column(children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                                left: 5.0, top: 4.0, bottom: 2.0, right: 220.0),
                            child: Text("2nd - 3rd Business Day Delivery",
                                style: new TextStyle(
                                    color: white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15.0)),
                          ),
                          Container(
                              margin: EdgeInsets.only(
                                  left: 0.0,
                                  top: 6.0,
                                  bottom: 0.0,
                                  right: 250.0),
                              child: Text("Estimated delivery in 2 - 3 Days",
                                  style: new TextStyle(
                                      color: white,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12.0))),
                          Container(
                              margin: EdgeInsets.only(
                                  left: 400.0,
                                  top: 0.0,
                                  bottom: 6.0,
                                  right: 0.0),
                              child: Text("R200",
                                  style: new TextStyle(
                                      color: white,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 20.0))),
                        ])),
                  ),
                )
              ])),
          SizedBox(
            height: 20,
          ),
          Container(
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //====================================================================================row

                  children: [
                Container(
                  width: 500,
                  height: 150,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        onPrimary: black, // background
                        primary: black,
                        textStyle: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Nunito Sans',
                          fontWeight: FontWeight.w300,
                        ),
                        side: BorderSide(color: lightblack, width: 2),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100)),
                      ),
                      onPressed: () {
                        setState(() {
                          n = 500;
                        });
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                CheckOutPayment()));
                      },
                      child: new Padding(
                          padding: EdgeInsets.fromLTRB(5, 25, 3, 0),
                          child: Column(children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                  left: 5.0,
                                  top: 8.0,
                                  bottom: 2.0,
                                  right: 300.0),
                              child: Text("Saturday DElivery",
                                  style: new TextStyle(
                                      color: white,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 15.0)),
                            ),
                            Container(
                                margin: EdgeInsets.only(
                                    left: 0.0,
                                    top: 12.0,
                                    bottom: 0.0,
                                    right: 250.0),
                                child: Text("Estimated delivery in 2 -3 days",
                                    style: new TextStyle(
                                        color: white,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12.0))),
                            Container(
                                margin: EdgeInsets.only(
                                    left: 400.0,
                                    top: 0.0,
                                    bottom: 12.0,
                                    right: 0.0),
                                child: Text("R500",
                                    style: new TextStyle(
                                        color: white,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 20.0))),
                          ]))),
                ),
              ])),
        ])));
  }
}