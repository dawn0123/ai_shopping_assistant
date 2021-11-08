
import 'package:aishop/screens/address/checkout_address.dart';
import 'package:aishop/screens/checkout/tabs.dart';
import 'package:aishop/utils/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addToOrders() async {
  DateTime now = new DateTime.now();
  DateTime date =
  new DateTime(now.year, now.month, now.day, now.hour, now.minute);

  DocumentReference ref = await FirebaseFirestore.instance.collection("Users").doc(uid);

  ref.collection('Cart').get().then((snapshots) => {
    snapshots.docs.forEach((productid) {
      FirebaseFirestore.instance.collection('Orders').doc(uid).set({
        'uid' : uid,
        'url': productid.get("url"),
        'name': productid.get("name"),
        'description': productid.get("description"),
        'category': productid.get('category'),
        'unit price': productid.get("price"),
        'total': productid.get("total"),
        'date': date,
        'quantity': productid.get("quantity"),
        'address' : selectedaddress,
        'default delivery': deliveryOption,
        'delivery cost': deliveryCost
      });
    })
  });

  int invoiceID = 0;
  double invoicetotal = 0;

  await ref.get().then((value) {
    invoiceID = value.get("invoices");
    invoicetotal = value.get("total")+value.get("delivery cost");
  });

  await ref.collection("Invoices").doc((invoiceID+1).toString()).set({
    'date': date,
    'address' : selectedaddress,
    'default delivery': deliveryOption,
    'delivery cost': deliveryCost,
    "invoice total": invoicetotal
  });

  await ref.collection('Cart').get().then((snapshots) => {
    snapshots.docs.forEach((productid) {
      ref.collection("Invoices").doc((invoiceID+1).toString()).collection("products").doc(productid.id).set({
        'name': productid.get("name"),
        'description': productid.get("description"),
        'category': productid.get('category'),
        'price': productid.get("price"),
        'quantity': productid.get("quantity"),
      });
      productid.reference.delete();
    })
  });

  await ref.update({"account" : FieldValue.increment(-invoicetotal), "total" : 0, "invoices": FieldValue.increment(1), "invoices total" : FieldValue.increment(invoicetotal)});
}