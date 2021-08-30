//kitchen model
import 'package:aishop/styles/theme.dart';
import 'package:aishop/widgets/product_model/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Kitchen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0,
      height: 400,
      child: StreamBuilder<QuerySnapshot>(
        //query database products collection by Kitchen category
        stream: FirebaseFirestore.instance
            .collection("Products")
            .where("category", isEqualTo: "Kitchen")
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return SizedBox(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(grey),
                backgroundColor: lightgrey,
              ),
            );
          } else {
            //build list of product items
            return GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 3 / 2,
                  mainAxisSpacing: 0),
              itemBuilder: (context, index) {
                return ProductCard(
                    snapshot.data!.docs[index].id,
                    snapshot.data!.docs[index].get('url'),
                    snapshot.data!.docs[index].get('name'),
                    snapshot.data!.docs[index].get('description'),
                    snapshot.data!.docs[index].get('price').toString(),
                    snapshot.data!.docs[index].get('stockamt'));
              },
              itemCount: snapshot.data!.docs.length,
            );
          }
        },
      ),
    );
  }
}