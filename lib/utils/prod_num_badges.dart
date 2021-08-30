// ignore: non_constant_identifier_names
import 'package:aishop/utils/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget Num_Of_Prod_in_Cart() {
  // ignore: non_constant_identifier_names
  num NumOfProd = 0;
  return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("Users")
          .doc(uid)
          .collection("Cart")
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          NumOfProd = 0;
          for(var i = 0; i < snapshot.data!.docs.length; i++){
            NumOfProd = NumOfProd + snapshot.data!.docs[i].get('quantity');
          }
          return Text(NumOfProd.toString());
        } else {
          return Text(NumOfProd.toString());
        }
      });
}

// ignore: non_constant_identifier_names
Widget Num_Of_Prod_in_Wishlist() {
  // ignore: non_constant_identifier_names
  var NumOfProd = 0;
  return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("Users")
          .doc(uid)
          .collection("Wishlist")
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          NumOfProd = snapshot.data!.docs.length;
          return Text(NumOfProd.toString());
        } else {
          return Text(NumOfProd.toString());
        }
      });
}