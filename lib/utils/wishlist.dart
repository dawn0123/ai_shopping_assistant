import 'package:aishop/utils/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Wishlist {
  final id, imgUrl, description, name, price, stockamt;

  Wishlist.addToCart(this.id, this.imgUrl, this.description, this.name,
      this.price, this.stockamt) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection("Wishlist")
        .doc(id)
        .set({
      'url': imgUrl,
      'name': name,
      'description': description,
      'price': price,
      'stockamt': stockamt
    });
  }

  Wishlist.removeFromCart(this.id, this.imgUrl, this.description, this.name,
      this.price, this.stockamt) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection("Wishlist")
        .doc(id)
        .delete();
  }
}