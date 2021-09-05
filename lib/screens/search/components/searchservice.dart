import 'package:cloud_firestore/cloud_firestore.dart';

class SearchService {
  increment(String itemname) async {
    FirebaseFirestore.instance
        .collection('Products')
        .where('name', isEqualTo: itemname)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((documentSnapshot) {
        documentSnapshot.reference.update({"clicks": FieldValue.increment(1)});
      });
    });
  }

  searchByName(String searchField) {
    return FirebaseFirestore.instance
        .collection('Products')
        .where('name', isGreaterThan: searchField)
        .get();
  }
}