import 'package:aishop/screens/cart/components/order_review.dart';
import 'package:aishop/styles/theme.dart';
import 'package:aishop/widgets/appbar/appbar.dart';
import 'package:aishop/widgets/product_model/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ClothesScreen extends StatefulWidget {
  @override
  _ClothesScreen createState() => _ClothesScreen();
}

class _ClothesScreen extends State<ClothesScreen> {
  @override
  Widget build(BuildContext context) {
    updateCartTotal();
    return Scaffold(
      backgroundColor: lightestgrey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: MyAppBar(
          title: Text("Clothes"),
          context: context,
        ),
      ),

      //Body of the home page
      body: ListView(children: <Widget>[
        //category
        Center(
          child: Text(
            "Clothes",
            style: TextStyle(fontSize: 40),
          ),
        ),
        Container(
          height: 800,
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Products")
                .where("category", isEqualTo: "Clothing")
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return SizedBox(
                  child: CircularProgressIndicator(
                    backgroundColor: lightgrey,
                    valueColor: new AlwaysStoppedAnimation<Color>(grey),
                  ),
                );
              } else {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      childAspectRatio: 2 / 3,
                      mainAxisSpacing: 0),
                  itemBuilder: (context, index) {
                    return ProductCard(
                      snapshot.data!.docs[index].id,
                      snapshot.data!.docs[index].get('url'),
                      snapshot.data!.docs[index].get('name'),
                      snapshot.data!.docs[index].get('description'),
                      snapshot.data!.docs[index].get('price').toString(),
                      snapshot.data!.docs[index].get('stockamt'),
                    );
                  },
                  itemCount: snapshot.data!.docs.length,
                );
              }
            },
          ),
        ),
      ]),
    );
  }
}