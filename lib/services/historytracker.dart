import 'package:aishop/utils/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryTracker {
  final id, imgUrl, description, name, price, stockamt;
  HistoryTracker.addToHistory(this.id, this.imgUrl, this.description, this.name,
      this.price, this.stockamt) {
    int index;
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('History')
        .doc(id)
        .get()
        .then((snapshot) => {
              FirebaseFirestore.instance
                  .collection('Users')
                  .doc(uid)
                  .collection("History")
                  .get()
                  .then((snapShots) => snapShots.docs.forEach((s) {
                        s.reference.update({'index': FieldValue.increment(1)});
                      })),
              FirebaseFirestore.instance
                  .collection('Users')
                  .doc(uid)
                  .collection("History")
                  .where("index", isGreaterThan: 20)
                  .get()
                  .then((value) => {
                        value.docs.forEach((element) {
                          element.reference.delete();
                        })
                      }),
              if (snapshot.data() == null || !snapshot.exists)
                {
                  FirebaseFirestore.instance
                      .collection('Users')
                      .doc(uid)
                      .collection("History")
                      .doc(id)
                      .set({
                    'url': imgUrl,
                    'name': name,
                    'description': description,
                    'price': price,
                    'click count': 1,
                    'index': 0,
                    'stockamt': stockamt
                  }),
                }
              else if (snapshot.get('click count') < 5)
                {
                  FirebaseFirestore.instance
                      .collection('Users')
                      .doc(uid)
                      .collection("History")
                      .doc(id)
                      .update(
                          {'click count': FieldValue.increment(1), 'index': 0}),
                }
              else
                {
                  FirebaseFirestore.instance
                      .collection('Users')
                      .doc(uid)
                      .collection("History")
                      .doc(id)
                      .get()
                      .then(
                        (value) => {
                          index = value.get('index'),
                          FirebaseFirestore.instance
                              .collection('Users')
                              .doc(uid)
                              .collection("History")
                              .where("index", isGreaterThan: index)
                              .get()
                              .then((value) => {
                                    value.docs.forEach((element) {
                                      element.reference.update({
                                        'index': FieldValue.increment(-1),
                                      });
                                    }),
                                  }),
                        },
                      ),
                  FirebaseFirestore.instance
                      .collection('Users')
                      .doc(uid)
                      .collection("History")
                      .doc(id)
                      .update({'index': 0}),
                }
            });
  }
}

void addToPurchases() {
  DateTime now = new DateTime.now();
  DateTime date =
      new DateTime(now.year, now.month, now.day, now.hour, now.minute);

  FirebaseFirestore.instance
      .collection('Users')
      .doc(uid)
      .collection('Cart')
      .get()
      .then((snapshots) => {
            snapshots.docs.forEach((productid) {
              FirebaseFirestore.instance
                  .collection('Users')
                  .doc(uid)
                  .collection('Purchases')
                  .doc(productid.id)
                  .get()
                  .then((snapshot) => {
                        if (snapshot.data() == null || !snapshot.exists)
                          {
                            FirebaseFirestore.instance
                                .collection('Users')
                                .doc(uid)
                                .collection("Purchases")
                                .doc(productid.id)
                                .set({
                              'url': productid.get("url"),
                              'name': productid.get("name"),
                              'description': productid.get("description"),
                              'price': productid.get("price"),
                                  'date': date
                            }),
                            /*FirebaseFirestore.instance
                                .collection('Users')
                                .doc(uid)
                                .collection("Purchases")
                                .doc(productid.id)
                                .collection("info")
                                .doc(date.toString())
                                .set({'quantity': 1, 'date': date}),*/
                            FirebaseFirestore.instance
                                .collection('Products')
                                .doc(productid.id)
                                .get()
                                .then((prodshot) {
                              FirebaseFirestore.instance
                                  .collection('Products')
                                  .doc(productid.id)
                                  .update({
                                'Purchased by': FieldValue.increment(1),
                                  'date': date
                              });
                            })
                          }
                        else
                          {
                            /*FirebaseFirestore.instance
                                .collection('Users')
                                .doc(uid)
                                .collection("Purchases")
                                .doc(productid.id)
                                .collection("info")
                                .doc(date.toString())
                                .set({'quantity': 1, 'date': date}),*/
                            FirebaseFirestore.instance
                                .collection('Products')
                                .doc(productid.id)
                                .get()
                                .then((prodshot) {
                              FirebaseFirestore.instance
                                  .collection('Products')
                                  .doc(productid.id)
                                  .update({
                                'Purchased by': FieldValue.increment(1), 
                                    'date': date
                              });
                            })
                          },
                        productid.reference.delete()
                      });
            })
          });
}