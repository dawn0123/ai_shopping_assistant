import 'package:aishop/screens/cart/components/order_review.dart';
import 'package:aishop/screens/checkout/tabs.dart';
import 'package:aishop/widgets/appbar/appbar.dart';
import 'package:flutter/material.dart';

class CheckOutPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CheckOutPage();
  }
}

class _CheckOutPage extends State<CheckOutPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(context: context),
      body: Row(
        children: <Widget> [
          Flexible(flex: 2 ,child: CheckOutDelivery()),
          Flexible(fit: FlexFit.tight ,child: OrderReview())
        ],
      ),
    );
  }
}