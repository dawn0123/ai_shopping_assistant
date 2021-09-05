

class StockManager {

  StockManager.addProducts(){
    addProducts();
  }

  Future<void> addProducts() async {

    //=============== Randomly generated Prices ================================
    /*var theprices =
    [49,79,109,129,139,159,169,179,189,209,219,249,259,289,299,359,389,399,409,
    419,429,439,449,469,489,1399,2039,2049,3679,4059,4429,5519,6679,7899,8279,
    8699,8779,8949,8969,9289,60,70,75,85,125,130,140,160,170,175,180,220,260,280,
    285,315,325,350,355,370,380,385,390,420,430,450,510,555,570,575,580,600,615,
    630,645,650,690,700,705,710,730,755,775,785,805,850,870,940,980,1000];

    //=============== Pictures file path in firebase storage ===================
    ListResult result =
    await FirebaseStorage.instance.ref()
        .child("Books")
        .listAll();

    //============== Adding all products in firebase database ==================
    // get all picture download links from storage and link them in database.
    result.items.forEach((Reference ref){
      //get download links
      ref.getDownloadURL().then((value) {
        var httpReference = FirebaseStorage.instance.refFromURL(value);
        //extract name from link
        String bookName = httpReference.name.split('.').first;
        //get random price from list
        var randomItem = (theprices..shuffle()).first;

        //add to product table.
        FirebaseFirestore.instance
            .collection('Products')
            .doc()
            .set({
          'url': value,
          'name': bookName,
          'category' : "Books",
          'description': "No description",
          'price': randomItem,
          'clicks': 0,
          'stockamt': 5000,
          'Purchased by' : 0,
        });
      });
    });

    //==================== Same Code for Clothing ==============================
    result =
    await FirebaseStorage.instance.ref()
        .child("Clothing")
        .listAll();

    result.items.forEach((Reference ref){
      ref.getDownloadURL().then((value) {
        var httpReference = FirebaseStorage.instance.refFromURL(value);
        String bookName = httpReference.name.split('.').first;

        var randomItem = (theprices..shuffle()).first;
        FirebaseFirestore.instance
            .collection('Products')
            .doc()
            .set({
          'url': value,
          'name': bookName,
          'category' : "Clothing",
          'description': "No description",
          'price': randomItem,
          'clicks': 0,
          'stockamt': 5000,
          'Purchased by' : 0,
        });
      });
    });

    //==================== Same Code for Shoes ==============================
    result =
    await FirebaseStorage.instance.ref()
        .child("Shoes")
        .listAll();

    result.items.forEach((Reference ref){
      ref.getDownloadURL().then((value) {
        var httpReference = FirebaseStorage.instance.refFromURL(value);
        String bookName = httpReference.name.split('.').first;
        var randomItem = (theprices..shuffle()).first;

        FirebaseFirestore.instance
            .collection('Products')
            .doc()
            .set({
          'url': value,
          'name': bookName,
          'category' : "Shoes",
          'description': "No description",
          'price': randomItem,
          'clicks': 0,
          'stockamt': 5000,
          'Purchased by' : 0,
        });
      });
    });

    //==================== Same Code for Kitchen ==============================
    result =
    await FirebaseStorage.instance.ref()
        .child("Kitchen")
        .listAll();

    result.items.forEach((Reference ref){
      ref.getDownloadURL().then((value) {
        var httpReference = FirebaseStorage.instance.refFromURL(value);
        String bookName = httpReference.name.split('.').first;

        var randomItem = (theprices..shuffle()).first;
        FirebaseFirestore.instance
            .collection('Products')
            .doc()
            .set({
          'url': value,
          'name': bookName,
          'category' : "Kitchen",
          'description': "No description",
          'price': randomItem,
          'clicks': 0,
          'stockamt': 5000,
          'Purchased by' : 0,
        });
      });
    });

    //==================== Same Code for Tech ==================================
    result =
    await FirebaseStorage.instance.ref()
        .child("Tech")
        .listAll();

    result.items.forEach((Reference ref){
      ref.getDownloadURL().then((value) {
        var httpReference = FirebaseStorage.instance.refFromURL(value);
        String bookName = httpReference.name.split('.').first;
        var randomItem = (theprices..shuffle()).first;

        FirebaseFirestore.instance
            .collection('Products')
            .doc()
            .set({
          'url': value,
          'name': bookName,
          'category' : "Tech",
          'description': "No description",
          'price': randomItem,
          'clicks': 0,
          'stockamt': 5000,
          'Purchased by' : 0,
        });
      });
    });*/
  }
}
