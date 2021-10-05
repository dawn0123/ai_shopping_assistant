import 'package:aishop/utils/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'DataCollection.dart';

var cart_total;

class Cart  {
  final id, imgUrl, description, name, price,quantity, stockamt, category;

  Cart.addToCart(this.id, this.imgUrl, this.description, this.name, this.price,
      this.quantity, this.stockamt, this.category) {
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
    DataCollection(name, id, price, "wishlist", category).DataCollector();
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