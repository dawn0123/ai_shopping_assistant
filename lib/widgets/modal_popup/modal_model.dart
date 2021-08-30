import 'package:aishop/icons/icons.dart';
import 'package:aishop/services/historytracker.dart';
import 'package:aishop/styles/theme.dart';
import 'package:aishop/utils/cart.dart';
import 'package:aishop/utils/wishlist.dart';
import 'package:flutter/material.dart';

Modal(context, id, imgUrl, name, description, price, stockamt) {
  int amount = stockamt;
  bool toggle = false;
  bool add = false;
  return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Center(
            child: Material(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
              // type: MaterialType.transparency,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black),
                padding: EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width * 0.7,
                height: 600,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.network(
                          imgUrl,
                          width: 250,
                          height: 250,
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        "Name: " + name,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text("Price: R " + price,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      SizedBox(
                        height: 5,
                      ),
                      Text("Description: " + description,
                          maxLines: 8,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white70)),
                      SizedBox(
                        height: 15,
                      ),
                      Center(
                          child: Wrap(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(50.0, 0, 0, 50.0),
                        ),
                        IconButton(
                          padding: const EdgeInsets.fromLTRB(0, 0, 25, 0),
                          icon: toggle
                              ? Icon(Icons.favorite,
                                  color: Colors.red, size: 35)
                              : Icon(AIicons.wishlist, color: white, size: 35),
                          onPressed: () {
                            setState(() {
                              toggle = !toggle;
                            });
                            if (toggle) {
                              Wishlist.addToCart(id, imgUrl, description, name,
                                  price, stockamt);

                              HistoryTracker.addToHistory(id, imgUrl,
                                  description, name, price, stockamt);
                            } else {
                              Wishlist.removeFromCart(id, imgUrl, description,
                                  name, price, stockamt);
                            }
                          },
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        (amount > 0)
                            ? ElevatedButton.icon(
                                onPressed: () {
                                  setState(() {
                                    add = !add;
                                  });
                                  double quantity = 1;
                                  if (add) {
                                    Cart.addToCart(id, imgUrl, name,
                                        description, price, quantity, stockamt);

                                    HistoryTracker.addToHistory(id, imgUrl,
                                        name, description, price, stockamt);
                                  } else {
                                    Cart.removeFromCart(id, imgUrl, name,
                                        description, price, quantity, stockamt);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.grey,
                                ),
                                icon: add
                                    ? Icon(
                                        Icons.done_all_sharp,
                                        size: 20,
                                        color: Colors.green,
                                      )
                                    : Icon(
                                        Icons.add_shopping_cart_rounded,
                                        size: 20,
                                        color: Colors.white,
                                      ),
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
                                            color: Colors.white),
                                      ),
                              )
                            : new Text('OUT OF STOCK',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Nunito Sans",
                                  color: Colors.red,
                                )),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0.0, 0, 50, 0),
                        ),
                      ])),
                      Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  10.0, 10.0, 10.0, 10.0),
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
                    ]),
              ),
            ),
          );
        });
      });
}