import 'package:aishop/services/datacollection.dart';
import 'package:aishop/utils/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Cart  {
  final id, imgUrl, description, name, price,quantity, stockamt, category;

  Cart.addToCart(this.id, this.imgUrl, this.description, this.name, this.price,this.quantity, this.stockamt, this.category) {
    FirebaseFirestore.instance.collection('Users').doc(uid).collection("Cart").doc(id).set(
        {
          'url': imgUrl,
          'name':name,
          'description':description,
          'price':price,
          'quantity':1,
          'stockamt': stockamt,
          'category' : category
        }
    );
    DataCollection(name, id, price, "cart", category, 1).DataCollector();
  }

  Cart.removeFromCart(this.id, this.imgUrl, this.description, this.name, this.price,this.quantity, this.stockamt, this.category){
    FirebaseFirestore.instance.collection('Users').doc(uid).collection("Cart").doc(id).delete();
  }
}