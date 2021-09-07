//model for one item
//take product details as parameters and return and clickable countainer that displays the image & price of product

import 'package:aishop/icons/icons.dart';
import 'package:aishop/screens/cart/components/order_review.dart';
import 'package:aishop/services/databasemanager.dart';
import 'package:aishop/services/historytracker.dart';
import 'package:aishop/styles/theme.dart';
import 'package:aishop/utils/cart.dart';
import 'package:aishop/utils/wishlist.dart';
import 'package:aishop/widgets/modal_popup/modal_model.dart';
import 'package:flutter/material.dart';

class RecommendationCard extends StatefulWidget {
  final String id;
  final String imgUrl;
  final String name;
  final String description;
  final String price;
  final int stockamt;
  final String category;

  RecommendationCard(this.id, this.imgUrl, this.name, this.description, this.price,
      this.stockamt, this.category);

  @override
  State<StatefulWidget> createState() {
    return _RecommendationCard();
  }
}

//model for one item
//take product details as parameters and return and clickable countainer that displays the image & price of product

class _RecommendationCard extends State<RecommendationCard> {
  bool toggle = false;
  bool add = false;

  @override
  Widget build(BuildContext context) {
    int amount = widget.stockamt;
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      child: Container(
          width: 200,
          height: 400,
          decoration: BoxDecoration(
              color: white,
              boxShadow: [
                BoxShadow(
                  color: accent,
                  blurRadius: 3,
                )
              ],
              borderRadius: BorderRadius.circular(20)),
          child:
          Column(crossAxisAlignment: CrossAxisAlignment.center, children: <
              Widget>[
            InkWell(
                onTap: () {
                  //add to history clicks
                  HistoryTracker.addToHistory(
                      widget.id,
                      widget.imgUrl,
                      widget.description,
                      widget.name,
                      widget.price,
                      widget.stockamt,
                      widget.category);
                  //on tap modal pop up
                  Modal(context, widget.id, widget.imgUrl, widget.name,
                      widget.description, widget.price, widget.stockamt, widget.category);
                  DatabaseManager().increment(widget.name);
                },
                splashColor: accent,
                customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)
                ),
                child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              //image from db
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.network(
                                  widget.imgUrl,
                                  width: 180,
                                  height: 200,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                              //text
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  widget.name,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Nunito Sans"),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              //price
                              Text("R " + widget.price,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.orange,
                                  )),
                            ],
                          ),
                        )))),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5.0, 20.0, 5.0, 10.0),
                    child: IconButton(
                      icon: toggle
                          ? Icon(Icons.favorite, color: Color(0xFFC90E0E), size: 30)
                          : Icon(AIicons.wishlist, color: lightblack, size: 30),
                      onPressed: () {
                        setState(() {
                          toggle = !toggle;
                        });
                        if (toggle) {
                          Wishlist.addToCart(
                              widget.id,
                              widget.imgUrl,
                              widget.description,
                              widget.name,
                              widget.price,
                              widget.stockamt,
                              widget.category);
                          HistoryTracker.addToHistory(
                              widget.id,
                              widget.imgUrl,
                              widget.description,
                              widget.name,
                              widget.price,
                              widget.stockamt,
                              widget.category);
                        } else
                          Wishlist.removeFromCart(
                              widget.id,
                              widget.imgUrl,
                              widget.description,
                              widget.name,
                              widget.price,
                              widget.stockamt,
                              widget.category);
                      },
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(5.0, 20.0, 5.0, 10.0),
                      child: (amount > 0)
                          ? ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              add = !add;
                            });
                            if (add) {
                              Cart.addToCart(
                                  widget.id,
                                  widget.imgUrl,
                                  widget.description,
                                  widget.name,
                                  widget.price,
                                  widget.stockamt,
                                  1, widget.category);
                              HistoryTracker.addToHistory(
                                  widget.id,
                                  widget.imgUrl,
                                  widget.description,
                                  widget.name,
                                  widget.price,
                                  widget.stockamt, widget.category);
                              updateCartTotal();
                            } else
                              Cart.removeFromCart(
                                  widget.id,
                                  widget.imgUrl,
                                  widget.description,
                                  widget.name,
                                  widget.price,
                                  widget.stockamt,
                                  1, widget.category);
                            updateCartTotal();
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xFFFCAE1E),
                              elevation: 0.5,
                          ),
                          icon: add
                              ? Icon(
                            Icons.done_all_sharp,
                            size: 20,
                            color: Color(0xFF0A0A0A)
                          )
                              : Icon(Icons.add_shopping_cart_rounded,
                              size: 20, color: Color(0xFF0A0A0A)),
                          label: add
                              ? Text(
                            "ADDED",
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: white),
                          )
                              : Text(
                            "ADD TO CART",
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: white),
                          ))
                          : new Text('OUT OF STOCK',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Nunito Sans",
                            color: Colors.red,
                          ))),
                ],
              ),
            ),
            Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                        child: (amount < 50 && amount != 0)
                            ? new Text('LOW IN STOCK',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Nunito Sans",
                              color: Colors.orange,
                            ))
                            : new Text(''),
                      )
                    ])),
          ])),
    );
  }
}