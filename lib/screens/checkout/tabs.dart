import 'package:aishop/screens/address/checkout_address.dart';
import 'package:aishop/screens/cart/components/checkoutpayment.dart';
import 'package:aishop/screens/delivery/checkoutdelivery.dart';
import 'package:aishop/styles/theme.dart';
import 'package:aishop/utils/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CheckOutDelivery extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _checkoutTabs();
  }
}
String? deliveryOption;
double? deliveryCost;
int? index;

Future<String> getDeliveryMethod()  async {
  String a = "Standard Delivery";
  deliveryCost = 70;
  await FirebaseFirestore.instance.collection("Users")
      .doc(uid)
      .get().then((value) {
    a = value.get('default delivery');
    deliveryCost = value.get('delivery cost');
    deliveryOption = value.get("default delivery");
    index = value.get('delivery index');
  });
  return a;
}

class _checkoutTabs extends State<CheckOutDelivery> with TickerProviderStateMixin {

  bool addressFocus = false;
  bool deliveryFocus = false;
  bool paymentFocus = false;

  late TabController _controller;

  int selectedIndex = 0;

  String defaultDeliveryMethod = "Standard Delivery";

  @override
  void initState() {
    super.initState();

    _controller = TabController(length: 3, vsync: this);

    _controller.addListener(() {
      setState(() {
        selectedIndex = _controller.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    getDeliveryMethod().then((value){
      setState(() {
        defaultDeliveryMethod = value;
      });
    });

    if(selectedIndex == 0){
      addressFocus = true;
      deliveryFocus = false;
      paymentFocus = false;
    }
    else if(selectedIndex == 1){
      addressFocus = false;
      deliveryFocus = true;
      paymentFocus = false;
    }
    else{
      addressFocus = false;
      deliveryFocus = false;
      paymentFocus = true;
    }

    return DefaultTabController(
        length: 3,
        child: Column(
          children: <Widget>[
            Container(
              color: lightgrey,
              constraints: BoxConstraints.expand(height: 100),
              child: TabBar(
                  controller: _controller,
                  indicatorColor: lightblack,
                  indicatorWeight: 3,
                  labelPadding: EdgeInsets.all(0),
                  tabs: [
                    !addressFocus? Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      color: lightgrey,
                      constraints: BoxConstraints.expand(),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                "Address",
                                textAlign: TextAlign.left,
                                style: (TextStyle(
                                    color: lightblack,
                                    fontFamily: "Inria Serif",
                                    fontSize: 30
                                ))
                            ),
                            Text(
                                (selectedaddress == null)? "Please select address to use": selectedaddress!,
                                maxLines: 1,
                                overflow: TextOverflow.fade,
                                softWrap: false,
                                textAlign: TextAlign.left,
                                style: (
                                    TextStyle(
                                      color: lighterblack,
                                      fontFamily: "Nunito Sans",
                                      fontSize: 15,
                                    )
                                )
                            ),
                          ]),
                    )
                        : Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      color: mediumgrey,
                      constraints: BoxConstraints.expand(),
                      child: Text(
                          "Address",
                          textAlign: TextAlign.center,
                          style: (TextStyle(
                              color: lightblack,
                              fontFamily: "Inria Serif",
                              fontSize: 30
                          ))
                      ),
                    ),
                    !deliveryFocus? Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      color: lightgrey,
                      constraints: BoxConstraints.expand(),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                "Delivery",
                                textAlign: TextAlign.left,
                                style: (TextStyle(
                                    color: lightblack,
                                    fontFamily: "Inria Serif",
                                    fontSize: 30
                                ))
                            ),
                            Text(
                                defaultDeliveryMethod,
                                maxLines: 1,
                                overflow: TextOverflow.fade,
                                softWrap: false,
                                textAlign: TextAlign.left,
                                style: (
                                    TextStyle(
                                      color: lighterblack,
                                      fontFamily: "Nunito Sans",
                                      fontSize: 15,
                                    )
                                )
                            ),
                          ]),
                    )
                        : Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      color: mediumgrey,
                      constraints: BoxConstraints.expand(),
                      child: Text(
                          "Delivery",
                          textAlign: TextAlign.center,
                          style: (TextStyle(
                              color: lightblack,
                              fontFamily: "Inria Serif",
                              fontSize: 30
                          ))
                      ),
                    ),
                    !paymentFocus? Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      color: lightgrey,
                      constraints: BoxConstraints.expand(),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                "Payment",
                                textAlign: TextAlign.left,
                                style: (TextStyle(
                                    color: lightblack,
                                    fontFamily: "Inria Serif",
                                    fontSize: 30
                                ))
                            ),
                            Text(
                                "Credit card",
                                maxLines: 1,
                                overflow: TextOverflow.fade,
                                softWrap: false,
                                textAlign: TextAlign.left,
                                style: (
                                    TextStyle(
                                      color: lighterblack,
                                      fontFamily: "Nunito Sans",
                                      fontSize: 15,
                                    )
                                )
                            ),
                          ]),
                    )
                        : Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      color: mediumgrey,
                      constraints: BoxConstraints.expand(),
                      child: Text(
                          "Payment",
                          textAlign: TextAlign.center,
                          style: (TextStyle(
                              color: lightblack,
                              fontFamily: "Inria Serif",
                              fontSize: 30
                          ))
                      ),
                    ),
                  ]),
            ),
            Expanded(
              child: Container(
                child: TabBarView(
                    controller: _controller,
                    children: [
                      CheckOutAddress(),
                      CheckoutDelivery(),
                      CheckOutPayment()
                    ]),
              ),
            )
          ],
        )
    );
  }

}