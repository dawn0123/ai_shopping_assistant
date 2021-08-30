import 'package:aishop/services/historytracker.dart';
import 'package:aishop/styles/theme.dart';
import 'package:aishop/utils/cart.dart';
import 'package:aishop/utils/wishlist.dart';
import 'package:aishop/widgets/modal_popup/modal_model.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class wishlistModel extends StatefulWidget {
  final prodname;
  final prodpicture;
  final prodprice;
  final proddescription;
  final cartid;
  final prodquantity;
  final int stockamt;

  wishlistModel(
      {this.prodname,
      this.prodpicture,
      this.prodprice,
      this.proddescription,
      this.cartid,
      this.prodquantity,
      required this.stockamt});

  @override
  _WishlistModel createState() => _WishlistModel();
}

class _WishlistModel extends State<wishlistModel> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shadowColor: Colors.blueGrey,
      child: ListTile(
          onTap: () {
            Modal(
                context,
                widget.cartid,
                widget.prodpicture,
                widget.proddescription,
                widget.prodname,
                widget.prodprice,
                widget.stockamt);
          },
          leading: new Image.network(
            widget.prodpicture,
            fit: BoxFit.fill,
          ),
          title: new Text(widget.prodname,
              style: TextStyle(
                  color: black, fontWeight: FontWeight.bold, fontSize: 15)),
          subtitle: new Column(children: <Widget>[
            new Row(
              children: <Widget>[
                Expanded(
                  child: new Text(
                    widget.proddescription,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(Icons.delete_outline_rounded),
                onPressed: () {
                  Wishlist.removeFromCart(
                      widget.cartid,
                      widget.prodpicture,
                      widget.proddescription,
                      widget.prodname,
                      widget.prodprice,
                      widget.stockamt);
                },
              ),
            ),
            Wrap(
              children: <Widget>[
                Container(
                  child: new Text("R" + widget.prodprice,
                      style: TextStyle(color: Color(0xFFFDD835), fontSize: 23)),
                ),
                Container(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () {
                        Cart.addToCart(
                            widget.cartid,
                            widget.prodpicture,
                            widget.proddescription,
                            widget.prodname,
                            widget.prodprice,
                            widget.prodquantity,
                            widget.stockamt);
                        HistoryTracker.addToHistory(
                            widget.cartid,
                            widget.prodpicture,
                            widget.proddescription,
                            widget.prodname,
                            widget.prodprice,
                            widget.stockamt);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black54,
                      ),
                      child: Text(
                        "Add To Cart",
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    )),
              ],
            )
          ])),
    );
  }
}