import 'package:aishop/utils/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

var cart_total;

class Cart  {
  final id, imgUrl, description, name, price,quantity, stockamt, category;

  Cart.addToCart(this.id, this.imgUrl, this.description, this.name, this.price,
      this.quantity, this.stockamt, this.category) {
    double t = 0;
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection("Cart")
        .doc(id)
        .set({
      'url': imgUrl,
      'name': name,
      'description': description,
      'price': price,
      'quantity': 1,
      'stockamt': stockamt,
      'total': price
    });

  }

  Cart.removeFromCart(this.id, this.imgUrl, this.description, this.name,
      this.price,this.quantity, this.stockamt, this.category){
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection("Cart")
        .doc(id)
        .delete();
  }
}