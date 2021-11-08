
import 'package:aishop/screens/invoices/components/invoice_model.dart';
import 'package:aishop/styles/theme.dart';
import 'package:aishop/utils/authentication.dart';
import 'package:aishop/widgets/appbar/appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class InvoicesPage extends StatefulWidget {
  @override
  _InvoicesPage createState() => _InvoicesPage();
}

getTotal() async {
  double cost = 0;
  await FirebaseFirestore.instance
      .collection('Users')
      .doc(uid).get().then((value){
    cost = value.get("invoices total");
  });
  return cost;
}

class _InvoicesPage extends State<InvoicesPage> {
  double TotalCost = 0;

  @override
  void initState() {
    getTotal().then((value){
      setState(() {
        TotalCost = value;
      });
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        appBar: MyAppBar(
          title: Text(
            'Invoices',
          ),
          context: context,
        ),
        body: Container(
            child: Column(
              children: <Widget>[
                Center(
                  child: Container(
                    child: Wrap(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(200, 0, 0, 0),
                        ),
                        Image(
                          image: AssetImage("images/cover.png"),
                          width: 600,
                        ),
                        SizedBox(
                          width: 150,
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    color: Colors.black45,
                    width: 1300,
                    height: 40,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Center(
                            child: Text("PDF",
                              style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: "Nunito Sans"),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text('Invoice Number',
                            style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: "Nunito Sans"),
                          ),
                        ),
                        Expanded(
                          child: Text('Date',
                            style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: "Nunito Sans"),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text('Address',
                            style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: "Nunito Sans"),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text('Total',
                              style: TextStyle(color: Colors.white, fontSize: 20,fontFamily: "Nunito Sans"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Invoice() ,
                ),
                SizedBox(
                  width: 800,
                ),
                Center(
                  child: Container(
                    width: 1300,
                    height: 38,
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 1040,
                          height: 50,
                        ),
                        Container(
                          width: 260,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(width: 2.0, color: lightblack),
                              bottom: BorderSide(width: 1.0, color: lightblack),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("R", style: TextStyle(fontFamily: "Nunito Sans", fontSize: 25)),
                              Text(TotalCost.toStringAsFixed(2),
                                  style: new TextStyle(
                                      fontWeight: FontWeight.w100, fontSize: 25)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )));
  }
}
