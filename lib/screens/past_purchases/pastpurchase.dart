import 'package:aishop/styles/theme.dart';
import 'package:aishop/utils/authentication.dart';
import 'package:aishop/widgets/appbar/appbar.dart';
import 'package:aishop/widgets/modal_popup/modal_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PastPurchase extends StatefulWidget {
  final String docu;
  final String tprice;
  final String orderi;
  const PastPurchase(this.docu,this.tprice,this.orderi);
  @override
  PastPurchaseState createState() => PastPurchaseState();
}

class PastPurchaseState extends State<PastPurchase> {
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: null,
        appBar: MyAppBar(
          title: Text(
            "Orders",
          ),
          context: context,
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('TestOrders')
                .doc(uid)
                .collection("Orders").doc(widget.docu).collection('products')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Modal(
                          context,
                          snapshot.data!.docs[index].id,
                          snapshot.data!.docs[index].get('url'),
                          snapshot.data!.docs[index].get('name'),
                          snapshot.data!.docs[index].get('description'),
                          snapshot.data!.docs[index]
                              .get('unit price')
                              .toString(),
                          snapshot.data!.docs[index].get('stockamt'),
                          snapshot.data!.docs[index].get('category'));
                    },
                    // Card Which Holds Layout Of ListView Item
                    child: Card(
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Image.network(
                                snapshot.data!.docs[index].get('url')),
                            width: 100,
                            height: 100,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  snapshot.data!.docs[index].get('name'),
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                 SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: 500,
                                  child: Text("Quantity: "+
                                      snapshot.data!.docs[index]
                                          .get('quantity').toString(),
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.grey[500]),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: 500,
                                  child: Text(
                                    "Unit Price: R"+
                                      snapshot.data!.docs[index]
                                          .get('unit price').toString(),
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.grey[500]),
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.only(
                                        left: 800.0,
                                        top: 0.0,
                                        bottom: 9.0,
                                        right: 0.0),
                                    child: Text(
                                        "Total : R" +
                                            snapshot.data!.docs[index]
                                                .get('total'),
                                        style: new TextStyle(
                                            color: lightblack,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 20.0))),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
            bottomNavigationBar: new Container(
          color: Color(0xD2242424),
          child: Row(
            children: <Widget>[
              Expanded(
                  child: ListTile(
                    title: new Text(
                      " Order: # "+widget.orderi,
                      style: TextStyle(color: white),
                    ),
                    subtitle: new Text(
                      " \n TOTAL :                       R"+widget.tprice,
                      style: TextStyle(color: white, fontSize: 19.0),
                    ),
                  ))
            ],
          ),
        )
    );
  }
}
