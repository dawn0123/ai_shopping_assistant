import 'package:aishop/screens/invoices/components/invoice_model.dart';
import 'package:aishop/screens/invoices/components/report.dart';
import 'package:aishop/styles/theme.dart';
import 'package:aishop/utils/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../Mocks/mock.dart';

void main() {
  List<Report> testList = List<Report>.empty(growable: true);
  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
  });
  
  Widget makeTestableWidget({required Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('invoice model ...', (tester) async {
    Invoice invoice = Invoice();
    await tester.pumpWidget(makeTestableWidget(child: invoice));
    Widget builder(){
      return Center(
      child: Container(
        width: 1300,
        height: 300,
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Users')
              .doc(uid)
              .collection("Purchases")
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
                  reportList.add(Report.fromMap({
                    'name': snapshot.data!.docs[index].get('name').toString(),
                    'price':
                        snapshot.data!.docs[index].get('unit price').toString(),
                    'quantity':
                        snapshot.data!.docs[index].get('qquantity').toString(),
                    'total': snapshot.data!.docs[index].get('total').toString()
                  }));
                  return Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black26)),
                      child: ListTile(
                        title: Row(
                          children: <Widget>[
                            Expanded(
                                child: Text("        " +
                                    snapshot.data!.docs[index]
                                        .get('name')
                                        .toString())),
                            Expanded(
                                child: Text(
                                    "                                  " +
                                        snapshot.data!.docs[index]
                                            .get('qquantity')
                                            .toString())),
                            Expanded(
                                child: Text(
                                    "                                     " +
                                        snapshot.data!.docs[index]
                                            .get('unit price')
                                            .toString())),
                            Expanded(
                                child: Text(
                                    "                                     " +
                                        snapshot.data!.docs[index]
                                            .get('total')
                                            .toString())),
                          ],
                        ),
                      ));
                },
                itemCount: snapshot.data!.docs.length,
              );
            }
          },
        ),
      ),
    );
    }
    await tester.pumpWidget(builder());
  });
}
