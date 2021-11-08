import 'package:aishop/styles/round_textfield.dart';
import 'package:aishop/styles/theme.dart';
import 'package:aishop/utils/authentication.dart';
import 'package:aishop/widgets/appbar/appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirstDelivaryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FirstDelivaryPage();
  }
}


class _FirstDelivaryPage extends State<FirstDelivaryPage> {

  @override
  void initState() {
    super.initState();
  }

  late String name,streetAdd,house,city,province,zipcode;

  TextEditingController nameController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController houseController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController provinceController = TextEditingController();
  TextEditingController zipcodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text(
          'Add Address',
          style: TextStyle(color: white),
        ),
        context: context,
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Container(
            padding: EdgeInsets.all(5),
            width: 460,

            alignment: Alignment.centerLeft,
            child: Text("Name",
                style: new TextStyle(
                    color: lightblack,
                    fontWeight: FontWeight.normal,
                    fontSize: 16.0)),
          ),
          Container(
            width: 450,
            height: 50,
            child: RoundTextField(
              control: nameController,
              text: 'Name of Place',
              autofocus: false,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: 460,
            padding: EdgeInsets.all(5),
            alignment: Alignment.centerLeft,
            child: Text("Street and number/P.O Box",
                style: new TextStyle(
                    color: lightblack,
                    fontWeight: FontWeight.normal,
                    fontSize: 16.0)),
          ),
          Container(
            width: 450,
            height: 50,
            child: RoundTextField(
              control: streetController,
              text: 'Street and number/P.O Box',
              autofocus: false,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: 450,
            height: 50,
            child: RoundTextField(
              control: houseController,
              text: 'Apartment, suit, unit, building, floor etc',
              autofocus: false,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: 460,
            padding: EdgeInsets.all(5),
            alignment: Alignment.centerLeft,
            child: Text("City",
                style: new TextStyle(
                    color: lightblack,
                    fontWeight: FontWeight.normal,
                    fontSize: 16.0)),
          ),
          Container(
            width: 450,
            height: 50,
            child: RoundTextField(
              control: cityController,
              text: 'City',
              autofocus: false,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: 460,
            padding: EdgeInsets.all(5),
            alignment: Alignment.centerLeft,
            child: Text("Province/State",
                style: new TextStyle(
                    color: lightblack,
                    fontWeight: FontWeight.normal,
                    fontSize: 16.0)),
          ),
          Container(
            width: 450,
            height: 50,
            child: RoundTextField(
              control: provinceController,
              text: 'Province/State',
              autofocus: false,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: 460,
            padding: EdgeInsets.all(5),
            alignment: Alignment.centerLeft,
            child: Text("Zip Code",
                style: new TextStyle(
                    color: lightblack,
                    fontWeight: FontWeight.normal,
                    fontSize: 16.0)),
          ),
          Container(
            width: 450,
            height: 50,
            child: RoundTextField(
              control: zipcodeController,
              text: 'Zip Code',
              autofocus: false,
            ),
          ),

          SizedBox(
            height: 20,
          ),
          Container(
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //====================================================================================row
                  children: [
                    Container(
                      width: 300,
                      height: 50,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onPrimary: lightblack, // background
                            primary: lightblack,
                            textStyle: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Nunito Sans',
                              fontWeight: FontWeight.w300,
                            ),
                            side: BorderSide(color: lightblack, width: 2),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100)),
                          ),
                          onPressed: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) =>
                                AlertDialog(
                                  title: const Text('Save Address'),
                                  content: const Text(
                                      'Are you sure?',
                                      style: TextStyle(
                                          color: Colors.greenAccent)),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('Confirm',
                                          style:
                                          TextStyle(color: Colors.black)),
                                      onPressed: () async {

                                        String newAddress = "";
                                        newAddress = nameController.text +" ,"
                                            +streetController.text+" ,"
                                            +houseController.text+" ,"
                                            +cityController.text+" ,"
                                            +provinceController.text+" ,"
                                            +zipcodeController.text;

                                        await FirebaseFirestore.instance
                                            .collection("Users")
                                            .doc(uid)
                                            .collection("info")
                                            .doc(uid)
                                            .update({
                                          "new Address": newAddress
                                        });

                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text('Cancel',
                                          style:
                                          TextStyle(color: Colors.black)),
                                      onPressed: () {
                                        Navigator.of(
                                            context).pop();
                                      },
                                    ),
                                  ],
                                ),
                          ),
                          child: Text("Save Address",
                              style: new TextStyle(
                                  color: lightestgrey,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 20.0))),
                    ),
                  ])),
          SizedBox(
            height: 20,
          ),
          Container(
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //====================================================================================row

                  children: [
                    Container(
                      width: 300,
                      height: 50,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onPrimary: lightblack, // background
                            primary: white,
                            textStyle: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Nunito Sans',
                              fontWeight: FontWeight.w300,
                            ),
                            side: BorderSide(color: lightblack, width: 2),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100)),
                          ),
                          onPressed: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) =>
                                AlertDialog(
                                  title: const Text('Discard'),
                                  content: const Text(
                                      'Your new address is not added ',
                                      style:
                                      TextStyle(color: Colors.redAccent)),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('OK',
                                          style:
                                          TextStyle(color: Colors.black)),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ),
                          ),
                          child: Text("Discard",
                              style: new TextStyle(
                                  color: lightblack,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 20.0))),
                    ),
                  ])),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}