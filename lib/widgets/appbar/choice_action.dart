import 'package:aishop/addons/popop_menu_consts.dart';
import 'package:aishop/screens/invoices/invoices.dart';
import 'package:aishop/screens/login/loginscreen.dart';
import 'package:aishop/screens/past_purchases/components/orders.dart';
import 'package:aishop/screens/past_purchases/pastpurchase.dart';
import 'package:aishop/screens/profile_page/edit_profile.dart';
import 'package:aishop/screens/settings/settings.dart';
import 'package:aishop/utils/authentication.dart';
import 'package:aishop/widgets/appbar/appbar.dart';
import 'package:flutter/material.dart';

void choiceAction(String choice) {
  if (choice == Constants.profile) {
    Navigator.push(
        contxt, new MaterialPageRoute(builder: (context) => EditProfilePage()));
  } else if (choice == Constants.settings) {
    Navigator.push(
        contxt, new MaterialPageRoute(builder: (context) => SettingsPage()));
  } else if (choice == Constants.orders) {
    Navigator.push(
        contxt, new MaterialPageRoute(builder: (context) => OrdersPage()));
  } else if (choice == Constants.invoices) {
    Navigator.push(
        contxt, new MaterialPageRoute(builder: (context) => InvoicesPage()));
  } else if (choice == Constants.signout) {
    signOut().then((response) => {
          if (response == "User signed out")
            {
              Navigator.of(contxt).push(MaterialPageRoute(
                  builder: (BuildContext context) => LoginScreen())),

              ScaffoldMessenger.of(contxt)
                  .showSnackBar(SnackBar(content: Text("You have signed out!")))
              // showDialog(
              //   context: contxt,
              //   builder: (BuildContext context) {
              //     return AlertDialog(
              //       title: new Text("Success!"),
              //       content: new Text(response),
              //       actions: <Widget>[
              //         ElevatedButton(
              //           child: new Text("OK"),
              //           onPressed: () {
              //             Navigator.of(context).pop();
              //             Navigator.of(context).push(MaterialPageRoute(
              //                 builder: (BuildContext context) =>
              //                     LoginScreen()));
              //           },
              //         ),
              //       ],
              //     );
              //   },
              // ),
            }
          else
            showDialog(
              context: contxt,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: new Text("Error!!"),
                  content: new Text(response),
                  actions: <Widget>[
                    ElevatedButton(
                      child: new Text("OK"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            )
        });
  }
}
