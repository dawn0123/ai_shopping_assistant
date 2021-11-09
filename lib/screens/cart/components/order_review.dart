import 'package:aishop/styles/theme.dart';
import 'package:aishop/utils/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'edit_cart.dart';

class OrderReview extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _OrderReview();
  }
}

double dcost = 0;
Future<double> getTotal()  async {
  double a = 0;
  await FirebaseFirestore.instance.collection("Users")
      .doc(uid)
      .get().then((value){
    a = value.get('total');
    dcost = value.get("delivery cost");
  });
  return a;
}

class _OrderReview extends State<OrderReview>{

  double total = 0;
  double deliverycost = 70;
  double subttotal = 0;

  @override
  void initState() {

    getTotal().then((value) {
      setState(() {
        subttotal = value;
        if(subttotal == 0)
          deliverycost = 0;
        else deliverycost = dcost;
        total = subttotal+deliverycost;
      });
    });

    deliverycost = dcost;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    getTotal().then((value) {
      setState(() {
        subttotal = value;
        if(subttotal == 0)
          deliverycost = 0;
        else deliverycost = dcost;
        total = subttotal+deliverycost;
      });
    });

    Size size = MediaQuery.of(context).size;
    return Container(
      color: lightblack,
      height: size.height,
      width: size.width * 0.3,
      child: Column(
        children: [
          Container(
            height: 100,
            padding: EdgeInsets.symmetric(horizontal: 50),
            color: white.withOpacity(0.04),
            alignment: Alignment.centerLeft,
            child: Text("Order Review",
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: white,
                  fontFamily: "Inria Serif",
                  fontSize: 30
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.all(20),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Users')
                    .doc(uid)
                    .collection("Cart").snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return SizedBox(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.blueGrey,
                      ),
                    );
                  } else {
                    return new ListView.builder(
                      itemBuilder: (context, index) {
                        return SingleCartProduct(
                          cartid: snapshot.data!.docs[index].id,
                          title: snapshot.data!.docs[index].get('name'),
                          imageURL: snapshot.data!.docs[index].get('url'),
                          quantity: snapshot.data!.docs[index].get('quantity'),
                          description: snapshot.data!.docs[index].get('description'),
                          price: snapshot.data!.docs[index].get('price'),
                        );
                      },
                      itemCount: snapshot.data!.docs.length,
                    );
                  }
                },
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              constraints: BoxConstraints.expand(),
              padding: EdgeInsets.symmetric(horizontal: 60, vertical: 20),
              color: white.withOpacity(0.04),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround
                    ,children: [
                    Expanded(
                      flex: 5,
                      child: Text("ORDER SUBTOTAL:",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Inria Serif",
                              color: white,
                              fontWeight: FontWeight.w100
                          )),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text("R",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Inria Serif",
                              color: white,
                              fontWeight: FontWeight.w100
                          )),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: Text(subttotal.toStringAsFixed(2),
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Inria Serif",
                              color: white,
                            )),
                      ),
                    )
                  ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround
                    ,children: [
                    Expanded(
                      flex: 5,
                      child: Text("Delivery:",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Inria Serif",
                              color: white,
                              fontWeight: FontWeight.w100
                          )),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text("R",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Inria Serif",
                              color: white,
                              fontWeight: FontWeight.w100
                          )),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(deliverycost.toStringAsFixed(2),
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Inria Serif",
                              color: white
                          )),
                    )
                  ],
                  ),
                  Divider(color: white,height: 20,indent: 10,endIndent: 10,thickness: 0.05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround
                    ,children: [
                    Expanded(
                      flex: 5,
                      child: Text("TOTAL:",
                          style: TextStyle(
                              fontSize: 25,
                              fontFamily: "Inria Serif",
                              color: white,
                              fontWeight: FontWeight.w100
                          )),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text("R",
                          style: TextStyle(
                              fontSize: 25,
                              fontFamily: "Inria Serif",
                              color: white,
                              fontWeight: FontWeight.w100
                          )),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(total.toStringAsFixed(2),
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Inria Serif",
                              color: white
                          )),
                    )
                  ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}