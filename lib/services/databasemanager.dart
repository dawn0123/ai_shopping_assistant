 import 'package:cloud_firestore/cloud_firestore.dart';

 Stream<QuerySnapshot<Map<String, dynamic>>>? _books;
 Stream<QuerySnapshot<Map<String, dynamic>>>? _shoes;
 Stream<QuerySnapshot<Map<String, dynamic>>>? _clothes;
 Stream<QuerySnapshot<Map<String, dynamic>>>? _tech;
 Stream<QuerySnapshot<Map<String, dynamic>>>? _kitchen;

class DatabaseManager {

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

  searchByName(String searchField) {
    return FirebaseFirestore.instance
        .collection('Products')
        .where('name', isGreaterThan: searchField)
        .get();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>?
  getBooks() => _books;

  setBooks() async => _books = await FirebaseFirestore.instance
        .collection("Products")
        .where("category", isEqualTo: "Books")
        .snapshots();

  Stream<QuerySnapshot<Map<String, dynamic>>>?
  getClothes() => _clothes;

  setClothes() async => _clothes = await FirebaseFirestore.instance
        .collection("Products")
        .where("category", isEqualTo: "Clothing")
        .snapshots();

  Stream<QuerySnapshot<Map<String, dynamic>>>?
  getKitchen() => _kitchen;

  setKitchen() async => _kitchen = await FirebaseFirestore.instance
        .collection("Products")
        .where("category", isEqualTo: "Kitchen")
        .snapshots();

  Stream<QuerySnapshot<Map<String, dynamic>>>?
  getShoes() => _shoes;

  setShoes() async => _shoes = await FirebaseFirestore.instance
        .collection("Products")
        .where("category", isEqualTo: "Shoes")
        .snapshots();

  Stream<QuerySnapshot<Map<String, dynamic>>>?
  getTech() => _tech;

  setTech() async => _tech = await FirebaseFirestore.instance
        .collection("Products")
        .where("category", isEqualTo: "Tech")
        .snapshots();
}