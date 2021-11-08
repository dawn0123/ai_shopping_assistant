import 'package:aishop/navigation/locator.dart';
import 'package:aishop/navigation/routing/route_names.dart';
import 'package:aishop/services/navigation_service.dart';
import 'package:aishop/styles/round_textfield.dart';
import 'package:aishop/styles/textlink.dart';
import 'package:aishop/styles/theme.dart';
import 'package:aishop/utils/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CheckOutAddress extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CheckOutAddress();
  }
}

String? selectedaddress;
String otherAddress = "*";
String? useAddress;

Future<String> getAddressses()  async {
  String address = "Pro Patria, Hillbrow, GT, South Africa";
  await FirebaseFirestore.instance.collection("Users")
      .doc(uid)
      .collection("info")
      .doc(uid)
      .get().then((value) async {
      address = value.get('location');
    if (value.data()!.containsKey("new Address"))
      otherAddress = value.get('new Address');
    else otherAddress = "*";
  });
  await FirebaseFirestore.instance.collection("Users")
      .doc(uid).get().then((value) {
    selectedaddress = value.get("use Address");
  });
  return address;
}

class _CheckOutAddress extends State<CheckOutAddress> {

  late TextEditingController userLocationController = TextEditingController();
  late TextEditingController newController = TextEditingController();

  String address = "Please add new address";
  bool anotherAddressExists = false;

  bool use1stAddress = false;
  bool use2ndAddress = false;

  @override
  void initState() {

    getAddressses().then((value){
      setState(() {
        address = value;
        if(selectedaddress == address) {
          use1stAddress = true;
          use2ndAddress = false;
        }
        else{
          use1stAddress = false;
          use2ndAddress = true;
        }
        if(otherAddress != "*")
          anotherAddressExists = true;
        else anotherAddressExists = false;
      });

      userLocationController.text = address;
      newController.text = otherAddress;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    getAddressses().then((value){
      setState(() {
        address = value;
        if(selectedaddress == address) {
          use1stAddress = true;
          use2ndAddress = false;
        }
        else{
          use1stAddress = false;
          use2ndAddress = true;
        }
        if(otherAddress != "*")
          anotherAddressExists = true;
        else anotherAddressExists = false;
      });
    });

    if(use1stAddress) selectedaddress = address;
    if(use2ndAddress) selectedaddress = otherAddress;

    return
      Scaffold(
        body: ListView(children: <Widget>[
          Container(
            width: 30,
            height: 300,
            margin: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 100),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                border: Border.all(
                    color: lightblack, width: 4)),
            child: ListView(children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Text.rich(
                TextSpan(
                  style: TextStyle(
                    fontSize: 17,
                  ),
                  children: [
                    WidgetSpan(
                        child: Padding(
                          padding:
                          const EdgeInsets.fromLTRB(
                              19, 10, 15, 0),
                          child: Icon(Icons.home, color: use1stAddress? accent: lightblack),
                        )),
                    TextSpan(
                        text: 'Home',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Inria Serif",
                            color: use1stAddress? accent: lightblack
                        )),
                    WidgetSpan(
                      child: TextLink(
                          text: address,
                          align: Alignment.center,
                          press: () =>
                          {
                            Alert(
                                context: context,
                                title: "New Address",
                                style: AlertStyle(
                                  backgroundColor: lightgrey,
                                  titleStyle: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Inria Serif",
                                  )
                                ),
                                content: Column(
                                  children: <Widget>[
                                    RoundTextField(
                                      autofocus: false,
                                      preicon: Icon(
                                          Icons.location_pin),
                                      text: "Location",
                                      control:
                                      userLocationController,
                                    ),
                                  ],
                                ),
                                buttons: [
                                  DialogButton(
                                    onPressed: () async {
                                      await FirebaseFirestore.instance
                                          .collection("Users")
                                          .doc(uid)
                                          .collection("info")
                                          .doc(uid)
                                          .update({
                                        "location": userLocationController.text
                                      });
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      "Save Changes",
                                      style: TextStyle(
                                          color: white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w100,
                                          fontFamily: "Inria Serif"
                                      ),
                                    ),
                                    color: lightblack,
                                  ),
                                  DialogButton(
                                    onPressed: () {
                                        Navigator.of(
                                            context).pop();
                                    },
                                    child: Text(
                                      "Close",
                                      style: TextStyle(
                                          color: white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w100,
                                          fontFamily: "Inria Serif"
                                      ),
                                    ),
                                    color: lightblack,
                                  ),
                                  DialogButton(
                                    onPressed: () async {
                                      Navigator.of(context).pop();

                                      setState(() {
                                        use2ndAddress = false;
                                        use1stAddress = true;
                                      });

                                      await FirebaseFirestore.instance
                                          .collection("Users")
                                          .doc(uid)
                                      .update({"use Address": address});

                                    },
                                    child: Text(
                                      "Use Address",
                                      style: TextStyle(
                                          color: white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w100,
                                          fontFamily: "Inria Serif"
                                      ),
                                    ),
                                    color: lightblack,
                                  ),
                                ]).show(),
                          }),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 20,
                thickness: 2,
                indent: 30,
                endIndent: 30,
                color: lightblack,
              ),
              anotherAddressExists? Text.rich(
                TextSpan(
                  style: TextStyle(
                    fontSize: 17,
                  ),
                  children: [
                    WidgetSpan(
                        child: Padding(
                          padding:
                          const EdgeInsets.fromLTRB(
                              19, 10, 15, 0),
                          child: Icon(Icons.home, color: use2ndAddress? accent: lightblack),
                        )),
                    TextSpan(
                        text: 'Another address',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Inria Serif",
                            color: use2ndAddress? accent: lightblack
                        )),
                    WidgetSpan(
                      child: TextLink(
                          text: otherAddress,
                          align: Alignment.center,
                          press: () =>
                          {
                            Alert(
                                context: context,
                                title: "Other Address",
                                style: AlertStyle(
                                    backgroundColor: lightgrey,
                                    titleStyle: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Inria Serif"
                                    )
                                ),
                                content: Column(
                                  children: <Widget>[
                                    RoundTextField(
                                      autofocus: false,
                                      preicon: Icon(
                                          Icons.location_pin),
                                      text: otherAddress,
                                      control: newController,
                                    ),
                                  ],
                                ),
                                buttons: [
                                  DialogButton(
                                    onPressed: () async {
                                      await FirebaseFirestore.instance
                                          .collection("Users")
                                          .doc(uid)
                                          .collection("info")
                                          .doc(uid)
                                          .update({
                                        "new Address": newController.text
                                      });
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      "Save Changes",
                                      style: TextStyle(
                                          color: white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w100,
                                          fontFamily: "Inria Serif"
                                      ),
                                    ),
                                    color: lightblack,
                                  ),
                                  DialogButton(
                                    onPressed: () {
                                      Navigator.of(
                                          context).pop();
                                    },
                                    child: Text(
                                      "Close",
                                      style: TextStyle(
                                          color: white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w100,
                                          fontFamily: "Inria Serif"
                                      ),
                                    ),
                                    color: lightblack,
                                  ),
                                  DialogButton(
                                    onPressed: () async {
                                      Navigator.of(context).pop();
                                      setState(() {
                                        use2ndAddress = true;
                                        use1stAddress = false;
                                      });

                                      await FirebaseFirestore.instance
                                          .collection("Users")
                                          .doc(uid)
                                          .update({"use Address": otherAddress});

                                    },
                                    child: Text(
                                      "Use Address",
                                      style: TextStyle(
                                          color: white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w100,
                                          fontFamily: "Inria Serif"
                                      ),
                                    ),
                                    color: lightblack,
                                  ),
                                ]).show(),
                          }),
                    ),
                  ],
                ),
              ): SizedBox.shrink(),
              anotherAddressExists? Divider(
                height: 20,
                thickness: 2,
                indent: 30,
                endIndent: 30,
                color: lightblack,
              ) : SizedBox.shrink(),
              Text.rich(
                TextSpan(
                  style: TextStyle(
                    fontSize: 17,
                  ),
                  children: [
                    WidgetSpan(
                        child: Padding(
                          padding:
                          const EdgeInsets.fromLTRB(
                              19, 10, 15, 0),
                          child: Icon(Icons.home),
                        )),
                    TextSpan(
                        text: 'Other Address',
                        style: TextStyle(
                          fontSize: 15.5,
                          fontWeight: FontWeight.bold,
                        )),
                    WidgetSpan(
                      child: TextLink(
                        text: " Add Address ",
                        align: Alignment.center,
                        press: () =>
                        {
                          locator<NavigationService>()
                              .globalNavigateTo(FirstDeliveryRoute, context)
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 20,
                thickness: 2,
                indent: 30,
                endIndent: 30,
                color: lightblack,
              ),
            ]),
          )
        ]),
      );
  }
}