import 'package:aishop/styles/theme.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final Icon icon;
  final String name;

  CategoryCard(this.icon, this.name);
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
            decoration: BoxDecoration(
                color: white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueGrey,
                    blurRadius: 5,
                  )
                ],
                borderRadius: BorderRadius.circular(20)),
            width: 200,
            child: Padding(
              padding: EdgeInsets.all(30.0),
              child: Column(
                children: <Widget>[
                  icon,
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    name,
                    style: TextStyle(fontSize: 20),
                  )
                ],
                //add text style Text(name,style: TextStyle(fontSize: 18, fontweight: FontWeight.bold))
              ),
            )));
  }
}