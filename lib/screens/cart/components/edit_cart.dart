import 'package:aishop/styles/theme.dart';
import 'package:aishop/utils/authentication.dart';
import 'package:aishop/utils/cart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SingleCartProduct extends StatefulWidget{

  final imageURL;
  final title;
  final description;
  final price;
  final quantity;
  final cartid;


  SingleCartProduct({
    this.imageURL,
    this.title,
    this.description,
    this.price,
    this.quantity,
    this.cartid});

  @override
  State<StatefulWidget> createState() {
    print(imageURL);
    return _CartItem();
  }
}

class _CartItem extends State<SingleCartProduct> {
  int q = 0, p = 0, oneItem = 0;
  @override
  void initState(){
    super.initState();
    oneItem = widget.price;
    q = widget.quantity;
    p = widget.quantity*widget.price;
  }

  @override
  Widget build(BuildContext context) {
    oneItem = widget.price;
    q = widget.quantity;
    p = widget.quantity*widget.price;
    return Container(
      margin: EdgeInsets.all(10),
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: white.withOpacity(0.02),
        boxShadow: [
          BoxShadow(
            color: mediumblack.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(50), bottomLeft: Radius.circular(50)),
              child: Image.network(
                widget.imageURL,
                width: 150,
                height: 150,
                fit: BoxFit.fill,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.title,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        maxLines: 1,
                        style: TextStyle(
                            color: white,
                            fontFamily: "Inria Serif",
                            fontSize: 20
                        )
                    ),
                    Container(
                      child: Text(
                        widget.description,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: TextStyle(color: lightgrey
                            ,fontFamily: "Nunito Sans",
                            fontSize: 18
                        ),
                        maxLines: 1,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(onPressed: () async {
                          if(q < 2){
                          delete(widget.cartid, p);
                        }
                        else{
                          reduce(widget.cartid, oneItem);
                        }

                        }, icon:
                        Icon(Icons.remove, color: accent)
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(q.toString(),
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: "Nunito Sans",
                                color: white.withOpacity(0.9),
                                fontWeight: FontWeight.w100
                            ),
                          ),
                        ),
                        IconButton(onPressed: () async {setState(() async {
                          increase(widget.cartid, oneItem);
                        });
                        }, icon:
                        Icon(Icons.add, color: accent)
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              width: 150,
              padding: EdgeInsets.only(right: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(onPressed: () async {
                    delete(widget.cartid, p);},
                    icon:
                  Icon(Icons.close,
                    color: white.withOpacity(0.9),
                    size: 30,
                  ),
                  ),
                  Text("R  "+p.toStringAsFixed(2),
                      style: TextStyle(
                          color: accent,
                          fontFamily: "Inria Serif",
                          fontSize: 20
                      ))
                ],
              ),
            )
          ]),
    );
  }
}

reduce(cartid, int oneItem) async {
  await FirebaseFirestore.instance
      .collection("Users")
      .doc(uid)
      .update({'total': FieldValue.increment(-oneItem)});
  await FirebaseFirestore.instance
      .collection("Users")
      .doc(uid)
      .collection("Cart")
      .doc(cartid)
      .update({'quantity': FieldValue.increment(-1)});
}

increase(cartid, int oneItem) async {
  await FirebaseFirestore.instance
      .collection("Users")
      .doc(uid)
      .collection("Cart")
      .doc(cartid)
      .update({'quantity': FieldValue.increment(1)});
  await FirebaseFirestore.instance
      .collection("Users")
      .doc(uid)
      .update({'total': FieldValue.increment(oneItem)
  });
}

delete(cartid, int p) async {
  await FirebaseFirestore.instance
      .collection("Users")
      .doc(uid)
      .update({'total': FieldValue.increment(-p)});
  Cart.removeFromCart(cartid, "", "", "", 0, 0, 0, "");
}