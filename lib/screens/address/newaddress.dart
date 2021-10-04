import 'package:cloud_firestore/cloud_firestore.dart';

class NewAddress {
  // getaddress(id){
  //   return new StreamBuilder(
  //       stream: FirebaseFirestore.instance.collection('users').doc(id).collection('info').doc(id).snapshots(),
  //       builder: (context, snapshot) {
  //         if (!snapshot.hasData) {
  //           return new Text("Loading");
  //         }
  //         var userDocument = snapshot.data;
  //         return ListView.builder(
  //           itemBuilder: (context,i){
  //             return Text(address: snapshot.data!.docs[i].get('Address'),)
  //           });
  //       }
  //   );
  // }
  homeaddress(String address,id,) {
    return FirebaseFirestore.instance
        .collection('Users')
        .doc(id)
        .collection('info')
        .doc(id)
        .set({
      'Home Address': address
    }
        ,SetOptions(merge: true)).then((value){
      //Do your stuff.
    });
  }

  workaddress(String address,id) {
    return FirebaseFirestore.instance
        .collection('Users')
        .doc(id)
        .collection('cart')
        .doc(id)
        .set({
      'Work Address': address
    }
        ,SetOptions(merge: true)).then((value){
      //Do your stuff.
    });
  }
  otheraddress(String name,streetAdd,house,city,province,zipcode,id) {
    String address = name +" , "+ streetAdd +' , '+ house +' , '+ city +' , '+ province +' , '+ zipcode;
    return FirebaseFirestore.instance
        .collection('Users')
        .doc(id)
        .collection('cart')
        .doc(id)
        .set({
      'Other Address': address
    }
        ,SetOptions(merge: true)).then((value){
      //Do your stuff.
    });
  }
}
