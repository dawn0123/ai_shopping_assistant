import 'package:aishop/screens/cart/components/order_review.dart';
import 'package:aishop/styles/theme.dart';
import 'package:aishop/utils/cart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SingleCartProduct extends StatefulWidget {
  final prodname;
  final prodpicture;
  final prodprice;
  final prodtotal;
  final prodquantity;
  final proddescription;
  final cartid;
  final prodindex;
  final stockamt;
  final category;

  SingleCartProduct(
      {this.prodname,
      this.prodpicture,
      this.prodprice,
      this.prodtotal,
      this.prodquantity,
      this.proddescription,
      this.prodindex,
      this.stockamt,
      this.cartid,
      this.category});

  @override
  _SingleCartProductState createState() => _SingleCartProductState();
}

class _SingleCartProductState extends State<SingleCartProduct> {

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xB7242424),
      child: ListTile(
        leading: new Image.network(
          widget.prodpicture,
          width: 70.0,
          height: 70.0,
        ),
        title: new Text(widget.prodname.toString(),
            style: TextStyle(color: white)),
        subtitle: new Column(
          children: <Widget>[
            new Row(
              children: <Widget>[
                Expanded(
                  child: new Text(
                    widget.proddescription,
                    style: TextStyle(color: lightgrey),
                    maxLines: 1,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            new Row(
              children: [
                GestureDetector(
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.yellow)),
                    child: Center(
                        child: Icon(
                      Icons.remove,
                      size: 10,
                      color: Colors.yellowAccent,
                    )),
                  ),
                  onTap: () async {
                    // remove 1 item of the same type
                    if (widget.prodquantity > 1) {
                      await FirebaseFirestore.instance
                          .collection('Users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection("Cart")
                          .where('name', isEqualTo: widget.prodname)
                          .get()
                          .then((value) => value.docs.forEach((element) => {
                                element.reference.update({
                                  "quantity": FieldValue.increment(-1),
                                  "total": FieldValue.increment(
                                      -double.parse(widget.prodprice))
                                })
                              }));

                      setState(() {

                        updateCartTotal();
                      });
                    } else if (widget.prodquantity == 1) {
                      // remove last item
                      Cart.removeFromCart(
                        widget.cartid,
                        widget.prodpicture,
                        widget.proddescription,
                        widget.prodname,
                        widget.prodprice,
                        widget.prodquantity,
                        widget.stockamt,
                        widget.category
                      );
                      setState(() {

                        updateCartTotal();
                      });
                    }
                  },
                ),
                SizedBox(
                  height: 5,
                  width: 10,
                ),
                Text(
                  "${widget.prodquantity.toString()}",
                  style: TextStyle(fontSize: 10, color: Colors.yellowAccent),
                ),
                SizedBox(
                  height: 5,
                  width: 10,
                ),
                GestureDetector(
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.yellow)),
                    child: Center(
                        child: Icon(
                      Icons.add,
                      size: 10,
                      color: Colors.yellowAccent,
                    )),
                  ),
                  onTap: () async {

                    // increment product quantity & product total

                    await FirebaseFirestore.instance
                        .collection('Users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection("Cart")
                        .where('name', isEqualTo: widget.prodname)
                        .get()
                        .then((value) => value.docs.forEach((element) => {
                              element.reference.update(
                                {
                                  "quantity": FieldValue.increment(1),
                                  "total": FieldValue.increment(
                                      double.parse(widget.prodprice))
                                },
                              )
                            }));

                    setState(() {

                      updateCartTotal();
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            new Container(
              alignment: Alignment.bottomRight,
              child: new Text(

                  "R" +
                      double.parse((double.parse(widget.prodprice) *
                                  (widget.prodquantity))
                              .toString())
                          .toString(),
                  style: TextStyle(color: Color(0xFFFDD835))),
            ),
            SizedBox(
              height: 10,
            ),
            new Row(
              children: <Widget>[
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        height: 0,
                        width: 0,
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          // remove from cart
                          Cart.removeFromCart(
                            widget.cartid,
                            widget.prodpicture,
                            widget.proddescription,
                            widget.prodname,
                            widget.prodprice,
                            widget.prodquantity,
                            widget.stockamt,
                            widget.category
                          );
                          setState(() {

                            updateCartTotal();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey,
                        ),
                        icon: Icon(
                          Icons.delete_outline_rounded,
                          size: 15,
                          color: Colors.black,
                        ),
                        label: Text(
                          "Remove",
                          style: TextStyle(
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.yellowAccent),
                        ),
                      ),
                    ],
                  ),
                ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
