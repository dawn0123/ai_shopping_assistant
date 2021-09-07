import 'package:aishop/icons/icons.dart';
import 'package:aishop/screens/cart/components/order_review.dart';
import 'package:aishop/screens/invoices/components/create_pdf.dart';
import 'package:aishop/screens/invoices/components/invoice_model.dart';
import 'package:aishop/styles/theme.dart';
import 'package:aishop/widgets/appbar/appbar.dart';
import 'package:flutter/material.dart';

class InvoicesPage extends StatefulWidget {
  @override
  Invoices createState() => Invoices();
}

class Invoices extends State<InvoicesPage> {
  @override
  Widget build(BuildContext context) {
    updateCartTotal();
    print(orderTotal);
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
                      width: 500,
                    ),
                    SizedBox(
                      width: 150,
                    ),
                    IconButton(
                        icon: Icon(AIicons.download,
                            color: Colors.black, size: 60),
                        onPressed: () {
                          createPDF();
                        }),
                  ],
                ),
              ),
            ),
            Center(
              child: Container(
                color: Colors.black45,
                width: 1300,
                height: 38,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        '                       Product Name',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '                       Quantity',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '                         Unit Price',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '                          Total',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Invoice(),
            ),
            SizedBox(
              width: 800,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(480, 0, 0, 0),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 300,
                          height: 30,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1)),
                          child: Text(
                              "                    " + qtyTotal.toString(),
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25)),
                        ),
                        Container(
                          width: 320,
                          height: 30,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1)),
                          child: Text(
                              "                                         Total",
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25)),
                        ),
                        Container(
                          width: 318,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1),
                          ),
                          child: Text("             R " + orderTotal.toString(),
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25)),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        )));
  }
}
