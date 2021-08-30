import 'package:aishop/screens/address/checkout_address.dart';
import 'package:aishop/screens/cart/components/order_review.dart';
import 'package:aishop/styles/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

User _user = FirebaseAuth.instance.currentUser!;

final CollectionReference usersRef = FirebaseFirestore.instance
    .collection('Users')
    .doc(_user.uid)
    .collection("Cart");
var productsoncart = [];

class CheckOutPage extends StatefulWidget {
  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  getdata() async {
    return usersRef;
  }

  @override
  void initState() {
   
    getUsers();

    super.initState();
  }

  getUsers() {
    usersRef.get().then((QuerySnapshot snapshot) {
      for (int i = 0; i < snapshot.docs.length; ++i) {
        productsoncart.add(snapshot.docs[i].data());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      updateCartTotal();
    });

    return DefaultTabController(
      length: 3,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  "Checkout Page",
                  textWidthBasis: TextWidthBasis.parent,
                  style: TextStyle(color: white),
                ),
                backgroundColor: lightblack,
                bottom: PreferredSize(
                  preferredSize: Size(MediaQuery.of(context).size.width, 50),
                  child: Text(
                    "Address",
                    style: TextStyle(color: white),
                    textWidthBasis: TextWidthBasis.parent,
                  ),
                ),
              ),
              body: CheckOutAddress(),
            ),
          ),
          Expanded(
              child: Scaffold(
            body: OrderReview(),
          )),
        ],
      ),
    );
  }
}