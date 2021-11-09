import 'package:aishop/icons/icons.dart';
import 'package:aishop/navigation/locator.dart';
import 'package:aishop/navigation/routing/route_names.dart';
import 'package:aishop/services/navigation_service.dart';
import 'package:aishop/widgets/category/category_card.dart';
import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 250,
        child: Center(
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
            children: <Widget>[
              //Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 0)),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    locator<NavigationService>()
                                      .globalNavigateTo(BooksRoute, context);
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (BuildContext context) => BooksScreen()));
                  },
                  splashColor: Colors.white30,
                  customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: CategoryCard(
                      Icon(
                        AIicons.books,
                        size: 70,
                      ),
                      "Books"),
                ),
              ),
              Padding(padding: EdgeInsets.fromLTRB(15, 0, 10, 0)),
              Material(
                child: InkWell(
                  onTap: () {
                    locator<NavigationService>()
                                      .globalNavigateTo(ClothesRoute, context);
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (BuildContext context) => ClothesScreen()));
                  },
                  splashColor: Colors.white30,
                  customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: CategoryCard(
                      Icon(
                        AIicons.clothes,
                        size: 70,
                      ),
                      "Clothes"),
                ),
              ),
              Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 0)),
              Material(
                child: InkWell(
                  onTap: () {
                    locator<NavigationService>()
                                      .globalNavigateTo(ShoesRoute, context);
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (BuildContext context) => ShoesScreen()));
                  },
                  splashColor: Colors.white30,
                  customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: CategoryCard(
                      Icon(
                        AIicons.shoe,
                        size: 70,
                      ),
                      "Shoes"),
                ),
              ),
              Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 0)),
              Material(
                child: InkWell(
                  onTap: () {
                    locator<NavigationService>()
                                      .globalNavigateTo(KitchenRoute, context);
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (BuildContext context) => KitchenScreen()));
                  },
                  splashColor: Colors.white30,
                  customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: CategoryCard(
                      Icon(
                        AIicons.kettle_black,
                        size: 70,
                      ),
                      "Kitchen"),
                ),
              ),
              Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 0)),
              Material(
                child: InkWell(
                    onTap: () {
                      locator<NavigationService>()
                                      .globalNavigateTo(TechRoute, context);
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (BuildContext context) => TechScreen()));
                    },
                    splashColor: Colors.white30,
                    customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: CategoryCard(
                        Icon(
                          AIicons.tech,
                          size: 70,
                        ),
                        "Tech")),
              ),
            ],
          ),
        ));
  }
}