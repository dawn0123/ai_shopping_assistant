
import 'package:aishop/styles/theme.dart';
import 'package:aishop/widgets/appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'components/online_invoice_model.dart';

class OnlineInvoicesPage extends StatefulWidget {
  String invoiceID;
  String address;
  String delivery;
  String date;
  double deliverycost;
  double total;

  OnlineInvoicesPage({
    required this.invoiceID,
    required this.address,
    required this.delivery,
    required this.date,
    required this.deliverycost,
    required this.total
  });

  @override
  _InvoicesPage createState() => _InvoicesPage();
}

class _InvoicesPage extends State<OnlineInvoicesPage> {

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
        body: Center(
          child: Container(
            width: 1300,
              child: ListView(
                children: <Widget>[
                  Center(
                    child: Image.network(
                      "assets/images/cover.png",
                      width: 500,
                    ),
                  ),
                  Container(
                      width: 1300,
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("ADDRESS",style: TextStyle(color: lightblack, fontSize: 22,fontFamily: "Nunito Sans"), ),
                          Text("INVOICE NUMBER", style: TextStyle(color: lightblack, fontSize: 22,fontFamily: "Nunito Sans"),),
                        ],
                      )),
                  Container(
                      width: 1300,
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(widget.address, style: TextStyle(color: lightblack, fontSize: 20,fontFamily: "Nunito Sans"),),
                          Text("#"+widget.invoiceID,style: TextStyle(color: lightblack, fontSize: 22,fontFamily: "Nunito Sans"),),
                        ],
                      )),
                  Container(
                      width: 1300,
                      height: 30,
                      child: Align(child: Text(widget.delivery,style: TextStyle(color: lightblack, fontSize: 20,fontFamily: "Nunito Sans"),), alignment: Alignment.centerLeft)
                  ),
                  Container(
                    width: 1300,
                    height: 10,
                  ),
                  Container(
                      width: 1300,
                      height: 10,
                      child: Divider(height: 1,color: black,thickness: 1)),
                  Container(
                    width: 1300,
                    height: 10,
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
                              child: Text('Product ID',
                                style: TextStyle(color: white, fontSize: 20,fontFamily: "Nunito Sans"),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text("Product name",
                                style: TextStyle(color: white, fontSize: 20, fontFamily: "Nunito Sans"),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text('Qty',
                                style: TextStyle(color: white, fontSize: 20, fontFamily: "Nunito Sans"),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text('Unit price',
                                style: TextStyle(color:white, fontSize: 20, fontFamily: "Nunito Sans"),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text('Cost',
                                style: TextStyle(color: white, fontSize: 20, fontFamily: "Nunito Sans"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: OnlineInvoice(invoiceID: widget.invoiceID) ,
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
                            width: 780,
                            height: 50,
                          ),
                          Container(
                            width: 260,
                            height: 50,
                              padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Text("SUBTOTAL:", style: TextStyle(color: lightblack, fontSize: 20, fontFamily: "Nunito Sans"))
                          ),
                          Container(
                            width: 260,
                            height: 50,
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("R", style: TextStyle(fontFamily: "Nunito Sans", fontSize: 25)),
                                Text((widget.total-widget.deliverycost).toStringAsFixed(2),
                                    style: new TextStyle(
                                        fontWeight: FontWeight.w100, fontSize: 22)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 1300,
                      height: 38,
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 780,
                            height: 50,
                          ),
                          Container(
                              width: 260,
                              height: 50,
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              child: Text("DELIVERY:", style: TextStyle(color: lightblack, fontSize: 20, fontFamily: "Nunito Sans"))
                          ),
                          Container(
                            width: 260,
                            height: 50,
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("R", style: TextStyle(fontFamily: "Nunito Sans", fontSize: 25)),
                                Text(widget.deliverycost.toStringAsFixed(2),
                                    style: new TextStyle(
                                        fontWeight: FontWeight.w100, fontSize: 22)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 1300,
                      height: 38,
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 780,
                            height: 50,
                          ),
                          Container(
                              width: 260,
                              height: 50,
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(width: 2.0, color: lightblack),
                                  bottom: BorderSide(width: 1.0, color: lightblack),
                                ),
                              ),
                              child: Text("GRAND TOTAL:", style: TextStyle(color: lightblack, fontSize: 22, fontFamily: "Nunito Sans"))
                          ),
                          Container(
                            width: 260,
                            height: 50,
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(width: 2.0, color: lightblack),
                                bottom: BorderSide(width: 1.0, color: lightblack),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("R", style: TextStyle(fontFamily: "Nunito Sans", fontSize: 25)),
                                Text((widget.total).toStringAsFixed(2),
                                    style: new TextStyle(
                                        fontWeight: FontWeight.w100, fontSize: 22)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ));
  }
}
