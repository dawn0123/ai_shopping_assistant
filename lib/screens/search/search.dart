import 'package:aishop/screens/search/components/searchservice.dart';
import 'package:aishop/styles/theme.dart';
import 'package:aishop/widgets/product_model/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  SearchState createState() => SearchState();
}

class SearchState extends State<Search> {
  var queryResultSet = [];
  var tempSearchStore = [];

  var capitalizedValue = ' ';

  initiateSearch(value) {
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }
    capitalizedValue = value.substring(0, 1).toUpperCase() + value.substring(1);

    if (queryResultSet.length == 0 && value.length > 0) {
      SearchService()
          .searchByName(capitalizedValue)
          .then((QuerySnapshot mydocs) {
        for (int i = 0; i < mydocs.docs.length; ++i) {
          queryResultSet.add(mydocs.docs[i]);
          setState(() {
            tempSearchStore.add(queryResultSet[i]);
          });
        }
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element['name'].toLowerCase().contains(value.toLowerCase()) ==
            true) {
          if (element["name"].toLowerCase().indexOf(value.toLowerCase()) == 0) {
            setState(() {
              tempSearchStore.add(element);
            });
          }
        }
      });
    }
    if (tempSearchStore.length == 0 && value.length > 1) {
      setState(() {});
    }
  }

  bool isSearching = false;
  int searchvalue = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (val) {
            initiateSearch(val);
            isSearching = true;
            searchvalue = capitalizedValue.length;
          },
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              hintText: "Search",
              hintStyle: TextStyle(color: Colors.white)),
          // icon: Icon(
          //   Icons.cancel,
          //   color: white,
          // ),
          // onPressed: () {
          //   setState(() {
          //     TextField.clear();
          //   });
          // },
        ),
        backgroundColor: Colors.black,
      ),
      // iconTheme: IconThemeData(color: Colors.white)),
      //Body of the home page
      body: capitalizedValue.length == 1
          ? Container(
              height: 800,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Products")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return SizedBox(
                      child: CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(grey),
                        backgroundColor: lightgrey,
                      ),
                    );
                  } else {
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          childAspectRatio: 2 / 3,
                          mainAxisSpacing: 0),
                      itemBuilder: (context, index) {
                        return ProductCard(
                          snapshot.data!.docs[index].id,
                          snapshot.data!.docs[index].get('url'),
                          snapshot.data!.docs[index].get('name'),
                          snapshot.data!.docs[index].get('description'),
                          snapshot.data!.docs[index].get('price').toString(),
                          snapshot.data!.docs[index].get('stockamt'),
                        );
                      },
                      itemCount: snapshot.data!.docs.length,
                    );
                  }
                },
              ),
            )
          : tempSearchStore.isNotEmpty && capitalizedValue.length > 1
              ? ListView(children: <Widget>[
                  SizedBox(height: 15.0, width: 10.0),
                  GridView.count(
                      padding: EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 10.0, bottom: 10),
                      crossAxisCount: 5,
                      childAspectRatio: (200 / 300),
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0,
                      primary: false,
                      shrinkWrap: true,
                      children: tempSearchStore.map((element) {
                        return ProductCard(
                            element.id.toString(),
                            element.data()['url'].toString(),
                            element.data()['name'].toString(),
                            element.data()['description'].toString(),
                            element.data()['price'].toString(),
                            element.data()['stockamt']);
                      }).toList())
                ])
              : tempSearchStore.isEmpty && capitalizedValue.length > 1
                  ? Container(
                      color: Colors.redAccent,
                      height: 50.0,
                      child: Center(
                        child: Text(
                          "No Results Found",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  : new Text(''),
    );
  }
}
