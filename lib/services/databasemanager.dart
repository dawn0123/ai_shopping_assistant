 import 'package:cloud_firestore/cloud_firestore.dart';

class DataService {
  searchByName(String searchField) {
    return FirebaseFirestore.instance
        .collection('Products')
        .where('name', isGreaterThan: searchField)
        .get();
  }

  increment(String itemname) async {
    FirebaseFirestore.instance.collection('Products')
        .where('name', isEqualTo: itemname)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((documentSnapshot) {
        documentSnapshot.reference.update({"clicks" : FieldValue.increment(1)});
      });
    });
  }
}