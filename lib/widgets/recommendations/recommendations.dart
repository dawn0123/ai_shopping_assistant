
import 'dart:convert';

import 'package:aishop/utils/authentication.dart';
import 'package:aishop/widgets/product_model/recommendation_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Recommendations extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Recommendations();
  }
}

class _Recommendations extends State<Recommendations>{
  var recommendations;
  @override
  Widget build(BuildContext context) {
    CollectionReference Products = FirebaseFirestore.instance.collection('Products');
    return FutureBuilder<String>(
      future: getRecommendations(), // async work
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return Text('Loading....');
          default:
            if (snapshot.hasError)
              return Text('Error: ${snapshot.error}');
            else
              recommendations = jsonDecode(snapshot.data.toString());
            return Container(
              height: 420,
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(vertical: 10),
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 3 / 2,
                    mainAxisSpacing: 0),
                itemBuilder: (context, index) {
                  while (index < recommendations.length) {
                    return FutureBuilder<DocumentSnapshot>(
                        future: Products.doc(recommendations[index]).get(),
                        builder:
                            (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshot1) {
                          if(snapshot1.hasData){
                            return RecommendationCard(
                                snapshot1.data!.id,
                                snapshot1.data!.get('url'),
                                snapshot1.data!.get('name'),
                                snapshot1.data!.get('description'),
                                snapshot1.data!.get('price'),
                                snapshot1.data!.get('stockamt'),
                                snapshot1.data!.get('category'));
                          }
                          else{
                            return Container(
                                alignment: Alignment.topCenter,
                                margin: EdgeInsets.only(top: 20),
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.grey,
                                  color: Colors.black,
                                ));
                          }
                        }
                    );
                  }
                  throw'';
                },
                itemCount: recommendations.length,
              ),
            );
        }
      },);
  }

  Future<String> getRecommendations()async {
    var url = "https://aish-python.herokuapp.com/decision_tree_customer?uid="+uid!;
    var uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    String data = response.body;
    return data;
  }



}