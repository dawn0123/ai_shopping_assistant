import 'package:aishop/screens/cart/components/edit_cart.dart';
import 'package:aishop/styles/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

double cartTotal = 0.00;
int sizethis = 0;
int count = 0;
double qtyTotal = 0;
double orderTotal = 0;

void updateCartTotal() async {
  double total = 0;
  double qty = 0;
  double ordTotal = 0;

  FirebaseFirestore.instance
      .collection("Users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("Purchases")
      .get()
      .then((querySnapshot) {
    querySnapshot.docs.forEach((result) {
      ordTotal += result.data()['total'];
      qty += result.data()['quantity'];
    });
    orderTotal = ordTotal;
    qtyTotal = qty;
  });

  FirebaseFirestore.instance
      .collection("Users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("Cart")
      .get()
      .then((querySnapshot) {
    querySnapshot.docs.forEach((result) {
      total += result.data()['total'];
    });
    cartTotal = total;
  });
}

// ignore: must_be_immutable
class OrderReview extends StatefulWidget {
  @override
  _OrderReviewState createState() => _OrderReviewState();
}

class _OrderReviewState extends State<OrderReview> {
  final CollectionReference usersRef = FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("Cart");

  etdata() async {
    return usersRef;
  }

  @override
  Widget build(BuildContext context) {
    updateCartTotal();
    print(cartTotal);
    return Scaffold(
        backgroundColor: lightblack,
        appBar: AppBar(
          primary: false,
          leading: Container(),
          title: Text(
            'Shopping Cart',
            style: TextStyle(
              fontSize: 25,
              color: lightblack,
              fontWeight: FontWeight.bold,
            ),
          ),
          toolbarHeight: 105,
          backgroundColor: Colors.white60,
        ),
        body: new StreamBuilder<QuerySnapshot>(
          stream: usersRef.snapshots(),
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
                    prodname: snapshot.data!.docs[index].get('name'),
                    prodpicture: snapshot.data!.docs[index].get('url'),
                    prodquantity: snapshot.data!.docs[index].get('quantity'),
                    proddescription:
                        snapshot.data!.docs[index].get('description'),
                    prodprice:
                        snapshot.data!.docs[index].get('price').toString(),
                    prodindex: index,
                    prodtotal:
                        snapshot.data!.docs[index].get('total').toString(),
                  );
                },
                itemCount: snapshot.data!.docs.length,
              );
            }
          },
        ),
        bottomNavigationBar: new Container(
          color: Color(0xD2242424),
          child: Row(
            children: <Widget>[
              Expanded(
                  child: ListTile(
                title: new Text(
                  " Cart Summary ",
                  style: TextStyle(color: white),
                ),
                subtitle: new Text(
                  " \n TOTAL :                       R $cartTotal",
                  style: TextStyle(color: white, fontSize: 19.0),
                ),
              ))
            ],
          ),
        ));
  }
}
