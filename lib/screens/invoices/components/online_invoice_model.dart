
import 'package:aishop/styles/theme.dart';
import 'package:aishop/utils/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OnlineInvoice extends StatelessWidget {
String invoiceID;

  OnlineInvoice({
  required this.invoiceID,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 1300,
        height: 300,
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Users')
              .doc(uid)
              .collection("Invoices")
              .doc(invoiceID)
              .collection("products")
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
                                child: Text(snapshot.data!.docs[index].id, style: TextStyle(color: lightblack, fontSize: 18,fontFamily: "Nunito Sans")), ),
                            Expanded(
                                child: Text(snapshot.data!.docs[index].get("name"), style: TextStyle(color: lightblack, fontSize: 18,fontFamily: "Nunito Sans"),)),
                            Expanded(
                                child: Center(child: Text(snapshot.data!.docs[index].get('quantity').toString(), style: TextStyle(color: lightblack, fontSize: 18,fontFamily: "Nunito Sans")))),
                            Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text("R"),
                                    Text(snapshot.data!.docs[index].get('price').toStringAsFixed(2),style: TextStyle(color: lightblack, fontSize: 18,fontFamily: "Nunito Sans")),
                                  ],
                                )),
                            Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text("R"),
                                    Text((snapshot.data!.docs[index].get('price')*snapshot.data!.docs[index].get('quantity')).toStringAsFixed(2), style: TextStyle(color: lightblack, fontSize: 18,fontFamily: "Nunito Sans")),
                                  ],
                                )),
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
}



