import 'package:aishop/styles/theme.dart';
import 'package:aishop/widgets/appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'order_model.dart';

class OrdersPage extends StatefulWidget {
  @override
  Orders createState() => Orders();
}

class Orders extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        appBar: MyAppBar(
          title: Text(
            'Orders',
          ),
          context: context,
        ),
        body: Container(
            // height: 400,
            // child: new SingleChildScrollView(
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
                      ],
                    ),
                  ),
                ),
                Center(
                  // child: new SingleChildScrollView(
                    child: Container(
                      color: Colors.black45,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              '                       Order ID',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '                       Order Amount',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '                         Purchase Date',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  // ),
                ),
                // Container(
                //   child:
                new SingleChildScrollView(
                  child: Order(),
                ),
                // ),
                // SizedBox(
                //   width: 80,
                // ),
              ],
            ))
        // )
        );
  }
}
