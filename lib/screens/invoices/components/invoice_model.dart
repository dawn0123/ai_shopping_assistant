import 'package:aishop/icons/icons.dart';
import 'package:aishop/screens/invoices/components/create_pdf.dart';
import 'package:aishop/screens/invoices/components/report.dart';
import 'package:aishop/screens/invoices/onlineInvoices.dart';
import 'package:aishop/styles/theme.dart';
import 'package:aishop/utils/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

List<Report> reportList = List<Report>.empty(growable: true);

class Invoice extends StatelessWidget {
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
              .orderBy('date', descending: true)
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
                    'invoiceID': snapshot.data!.docs[index].id,
                    'date': snapshot.data!.docs[index].get('date').toString(),
                    'address':snapshot.data!.docs[index].get('address'),
                    'total': snapshot.data!.docs[index].get('invoice total')
                  }));
                  return Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black26)),
                      child: ListTile(
                        title: Row(
                          children: <Widget>[
                            Expanded(
                                child: IconButton(icon: Icon(AIicons.download, size: 25, color: accent), onPressed: () {
                                  createPDF(invoiceID: snapshot.data!.docs[index].id);
                                },)),
                            Expanded(
                                child: TextButton(child: Text(snapshot.data!.docs[index].id, style: TextStyle(color: Colors.blueAccent, fontSize: 16)), onPressed: (){
                                  Navigator.of(context).push(MaterialPageRoute( builder: (BuildContext context) =>
                                      OnlineInvoicesPage(
                                        invoiceID: snapshot.data!.docs[index].id,
                                        address: snapshot.data!.docs[index].get('address'),
                                        date: snapshot.data!.docs[index].get('date').toString(),
                                        delivery: snapshot.data!.docs[index].get('default delivery').toString(),
                                        deliverycost:snapshot.data!.docs[index].get('delivery cost') ,
                                        total: snapshot.data!.docs[index].get('invoice total'),
                                      )
                                  )
                                  );
                                },)),
                            Expanded(
                                child: Text(DateFormat('dd-MM-yyyy').format(snapshot.data!.docs[index].get('date').toDate()).toString())),
                            Expanded(
                                flex: 2,
                                child: Text(snapshot.data!.docs[index].get('address'))),
                            Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text("R"),
                                    Text(snapshot.data!.docs[index].get('invoice total').toStringAsFixed(2)),
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



