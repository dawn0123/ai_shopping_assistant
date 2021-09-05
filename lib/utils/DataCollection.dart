import 'package:aishop/utils/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataCollection{
  final product_name, product_id, price, event, category;

  DataCollection(this.product_name, this.product_id, this.price, this.event, this.category);

  Future <String> getLocation() async {
    String location = "";
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection("info")
        .doc(uid)
        .get()
        .then((DocumentSnapshot ds) {
      location = ds.get('location');
    }
    );
    return location;
  }

  Future <String> getProvince() async {
    String province = "";
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection("info")
        .doc(uid)
        .get()
        .then((DocumentSnapshot ds) {
      province = ds.get('province');
    }
    );
    return province;
  }
//DON'T YOU DARE!!!!!!!!!!!!!!!!!! DO NOT!!!!! UNCOMMENT THIS SECTION!!!
  /*Future <void> ProductToData() async {

    DateTime now = new DateTime.now();
    DateTime date =  new DateTime(now.year, now.month, now.day, now.hour, now.minute);

     FirebaseFirestore.instance
         .collection('Products')
         .get()
         .then((QuerySnapshot querySnapshot) => {
           querySnapshot.docs.forEach((DocumentSnapshot ds) {
             FirebaseFirestore.instance
                 .collection('Data')
                 .doc()
                 .set({
               'uid' : null,
               'date' : date,
               'product_name' : ds.get('name'),
               'product_id' : ds.id,
               'product_category' : ds.get('category'),
               'event' : null,
               'location' : null,
               'province' : null,
               'cost' : ds.get('price'),
               'recommend': 'yes'
             });
           })
     });
  }*/

  Future<void> DataCollector() async {
    DateTime now = new DateTime.now();
    DateTime date =  new DateTime(now.year, now.month, now.day, now.hour, now.minute);

    var location = await getLocation();
    var province = await getProvince();

    var recommend = 'no';
    if(event == 'view' || event == 'wishlist'){
      recommend = 'yes';
    }

    FirebaseFirestore.instance
        .collection('Data')
        .doc()
        .set({
      'uid' : uid,
      'date' : date,
      'product_name' : product_name,
      'product_id' : product_id,
      'product_category' : category,
      'event' : event,
      'location' : location,
      'province' : province,
      'cost' : price,
      'recommend' : recommend
    });
  }
//THIS CODE MUST BE ONLY UNCOMMENTED WHEN YOU WANT TO UPDATE THE CSV FILE.. MAYBE TWICE A WEEK!!!
/*
   MakeCSV() async {
     var Data = await FirebaseFirestore.instance
         .collection("Data")
         .get();
     List<List<dynamic>> table = [[]];
     table.add([
       "Product_Id",
       "Product_Name",
       "Product_Category",
       "User-Name",
       "User_Location",
       "User_Province"
       "Event",
       "Cost",
       "Date",
       "Recommend"
     ]);
     Data.docs.forEach((DocumentSnapshot ds) {
       DateTime date = ds.get("date").toDate();
       List<dynamic> row = [];
       row.add(ds.get("product_id"));
       row.add(ds.get("product_name"));
       row.add(ds.get("product_category"));
       row.add(ds.get("name"));
       row.add(ds.get("location"));
       row.add(ds.get("province"))
       row.add(ds.get("event"));
       row.add(ds.get("cost"));
       row.add(date);
       row.add(ds.get("recommend"));
       table.add(row);
     });
     String csvfile = ListToCsvConverter().convert(table);
     print(csvfile);
     new AnchorElement(href: "data:text/plain;charset=utf-8, $csvfile")
       ..setAttribute("download", "data.csv")
       ..click();
   }
    */
}
