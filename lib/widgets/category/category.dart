import 'package:aishop/icons/icons.dart';
import 'package:aishop/screens/categories/books.dart';
import 'package:aishop/screens/categories/clothes.dart';
import 'package:aishop/screens/categories/kitchen.dart';
import 'package:aishop/screens/categories/shoes.dart';
import 'package:aishop/screens/categories/tech.dart';
import 'package:aishop/widgets/category/category_card.dart';
import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            height: 250,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.fromLTRB(85, 0, 0, 0),
              children: <Widget>[
                Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 0)),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => BooksScreen()));
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
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => ClothesScreen()));
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
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => ShoesScreen()));
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
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => KitchenScreen()));
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
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => TechScreen()));
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
            )));
  }
}