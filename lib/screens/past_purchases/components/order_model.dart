import 'package:aishop/styles/theme.dart';
import 'package:aishop/utils/authentication.dart';
import 'package:aishop/screens/invoices/components/report.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:aishop/screens/past_purchases/pastpurchase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class Order extends StatelessWidget with ChangeNotifier {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: new SingleChildScrollView(
      child: Container(
        height: 100 * (MediaQuery.of(context).copyWith().size.height/6.34),
        width: 1300,
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('TestOrders')
              .doc(uid)
              .collection('Orders')
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
              return ListView.builder(
                itemBuilder: (context, index) {
                  return Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black26)),
                      child: ListTile(
                        title: Row(
                          children: <Widget>[
                            Expanded(
                                child: Text("        #" +
                                    snapshot.data!.docs[index]
                                        .get('orderid')
                                        .toString())),
                            Expanded(
                                child: Text(
                                    "                                  " +
                                        "R" +
                                        snapshot.data!.docs[index]
                                            .get('orderprice')
                                            .toString())),
                            Expanded(
                                child: Text(
                                    "                                     " +
                                        snapshot.data!.docs[index].id
                                            .toString())),
                          ],
                        ),
                        onTap: () => {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => PastPurchase(
                                  snapshot.data!.docs[index].id,
                                  snapshot.data!.docs[index]
                                      .get('orderprice')
                                      .toString(),
                                  snapshot.data!.docs[index]
                                      .get('orderid')
                                      .toString())))
                        },
                      ));
                },
                itemCount: snapshot.data!.docs.length,
              );
            }
          },
        ),
      ),
      ),
    );
  }
}
