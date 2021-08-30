import 'dart:math';

import 'package:aishop/utils/authentication.dart';
import 'package:aishop/widgets/product_model/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Recommendations extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    
    return _Recommendations();
  }
}

class _Recommendations extends State<Recommendations> {
  @override
  Widget build(BuildContext context) {
    List<DocumentSnapshot> recommendations = [];
    // ignore: non_constant_identifier_names
    List<DocumentSnapshot> Purchases = [];
    // ignore: non_constant_identifier_names
    List<DocumentSnapshot> Wishlist = [];
    // ignore: non_constant_identifier_names
    List<DocumentSnapshot> Most_Purchased = [];
    return Container(
        height: 400,
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Users")
                .doc(uid)
                .collection("History")
                .snapshots(),
            builder: (context, snapshot1) {
              if (snapshot1.hasData) {
                recommendations = snapshot1.data!.docs;
              }
              return StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("Users")
                      .doc(uid)
                      .collection("Wishlist")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      Wishlist = snapshot.data!.docs;
                    }
                    return StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("Products")
                            .where("Purchased by", isGreaterThan: 0)
                            .orderBy("Purchased by", descending: false)
                            .snapshots(),
                        builder: (context, snapshot3) {
                          if (snapshot3.hasData) {
                            //taking the 20 most purchased products
                            if(snapshot3.data!.docs.length >= 20){
                              Most_Purchased.clear();
                              for(var i = 0; i < 20; i++){
                                Most_Purchased.add(snapshot3.data!.docs[i]);
                              }
                            }
                            else{
                              Most_Purchased = snapshot3.data!.docs;
                            }
                          }
                          return StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection("Users")
                                  .doc(uid)
                                  .collection("Purchases")
                                  .snapshots(),
                              builder: (context, snapshot2) {
                                if (snapshot2.hasData) {
                                  Purchases = snapshot2.data!.docs;
                                }
                                //New users
                                if (Wishlist.isEmpty && recommendations.isEmpty && Purchases.isEmpty) {
                                  recommendations = randoms(Most_Purchased);
                                }
                                //recommending based of history
                                if (recommendations.isNotEmpty && Purchases.isNotEmpty) {
                                  for (var i = 0; i < recommendations.length; i++) {
                                    for (var j = 0; j < Purchases.length; j++) {
                                      if (recommendations[i].id == Purchases[j].id) {
                                        recommendations.remove(recommendations[i]);
                                        if (i == recommendations.length)
                                          i = i - 1;
                                      }
                                    }
                                  }
                                }
                                //recommending based on items in a wishlist
                                if (recommendations.isNotEmpty && Wishlist.isNotEmpty) {
                                  for (var i = 0; i < recommendations.length; i++) {
                                    for (var j = 0; j < Wishlist.length; j++) {
                                      if (recommendations[i].id == Wishlist[j].id) {
                                        Wishlist.remove(Wishlist[j]);
                                        if (j == Wishlist.length) j = j - 1;
                                      }
                                    }
                                  }
                                  for (var count = 0; count < Wishlist.length; count++) {
                                    recommendations.add(Wishlist[count]);
                                  }
                                }
                                //recommending based on most purchased
                                if (recommendations.isNotEmpty && Most_Purchased.isNotEmpty) {
                                  for (var i = 0; i < recommendations.length; i++) {
                                    for (var j = 0; j < Most_Purchased.length; j++) {
                                      if (recommendations[i].id == Most_Purchased[j].id) {
                                        //recommendations.removeAt(i);
                                        Most_Purchased.remove(Most_Purchased[j]);
                                        if (j == Most_Purchased.length)
                                          j = j - 1;
                                      }
                                    }
                                  }
                                  for (var count = 0; count < Most_Purchased.length; count++) {
                                    recommendations.add(Most_Purchased[count]);
                                  }
                                }

                                if (recommendations.length != 0) {
                                  //recommendations..shuffle();
                                  for (var i = 0; i < recommendations.length; i++) {
                                    return GridView.builder(
                                      scrollDirection: Axis.horizontal,
                                      gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 1,
                                          childAspectRatio: 3 / 2,
                                          mainAxisSpacing: 0),
                                      itemBuilder: (context, index) {
                                        while (index < recommendations.length) {
                                          return ProductCard(
                                            recommendations[index].id,
                                            recommendations[index].get('url'),
                                            recommendations[index].get('name'),
                                            recommendations[index].get('description'),
                                            recommendations[index].get('price').toString(),
                                            recommendations[index].get('stockamt'),
                                          );
                                        }
                                        throw '';
                                      },
                                      itemCount: recommendations.length,
                                    );
                                  }

                                } else {
                                  return Text("No Recommendations yet");
                                }
                                throw'';
                              });
                        });
                  });
            }));
  }
  List<DocumentSnapshot> randoms(List<DocumentSnapshot> MostPurchased){
    List<DocumentSnapshot> randomized = [];
    for(var i = 0; i < MostPurchased.length; i++){
      var cat = MostPurchased[i].get("category");
      Stream<QuerySnapshot> stream = FirebaseFirestore.instance.collection("Products").where("category", isEqualTo: cat).snapshots();
      stream.forEach((element) {
        if(element != null){
          element.docs..shuffle();
          element.docs..reversed;
          element.docs..shuffle();
          element.docs..shuffle();
          element.docs..reversed;
          element.docs..shuffle();
          final _random = new Random();
          final doc = element.docs[_random.nextInt(element.docs.length)];
          if(randomized.length <= 20){
            if(randomized.length == 0){
              randomized.add(doc);
            }
            else{
              if(!_contains(randomized, doc)){
                randomized.add(doc);
              }
            }
          }
        }
      });
    }
    return randomized;
  }
  bool _contains(List<DocumentSnapshot> list, QueryDocumentSnapshot<Object?> documentSnapshot){
    var counter = 0;
    var state = false;
    for(var i = 0; i < list.length; i++){
      if(list[i].data() == documentSnapshot.data()){
        counter++;
      }
    }
    if(counter > 0){
      state =  true;
    }
    return state;
  }
}