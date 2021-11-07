import 'package:aishop/addons/popop_menu_consts.dart';
import 'package:aishop/icons/icons.dart';
import 'package:aishop/screens/cart/checkout_page.dart';
import 'package:aishop/screens/wishlist/wislistscreen.dart';
import 'package:aishop/styles/theme.dart';
import 'package:aishop/utils/prod_num_badges.dart';
import 'package:aishop/widgets/appbar/choice_action.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

BuildContext contxt = "" as BuildContext;

class MyAppBar extends AppBar {
  MyAppBar({Key? key, Widget? title, required BuildContext context})
      : super(
            key: key,
            title: title,
            backgroundColor: lightblack,
            actions: <Widget>[
              IconButton(
                icon: Badge(
                  badgeContent: Num_Of_Prod_in_Wishlist(),
                  toAnimate: true,
                  animationType: BadgeAnimationType.scale,
                  child: Icon(
                    AIicons.wishlist,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                onPressed: () {
                  // Go to wishlist
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => WishlistPage()));
                },
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: IconButton(
                    icon: Badge(
                      toAnimate: true,
                      animationType: BadgeAnimationType.scale,
                      badgeContent: Num_Of_Prod_in_Cart(),
                      child: Icon(
                        AIicons.cart,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    onPressed: () {
                      // Go to cart
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => CheckOutPage()));
                    },
                  )),
              Padding(
                padding: EdgeInsets.fromLTRB(5, 0, 20, 0),
                child: PopupMenuButton<String>(
                  child: Center(
                      child: Icon(
                    AIicons.profile,
                    size: 30,
                  )),
                  itemBuilder: (context) {
                    contxt = context;
                    return Constants.choices.map((String choice) {
                      return PopupMenuItem<String>(
                        child: Text(choice),
                        value: choice,
                      );
                    }).toList();
                  },
                  onSelected: choiceAction,
                ),
              ),
            ]);
}
