// maps names to values
class Report {
  String name;
  String quantity;
  String price;
  String total;

  Report({
    required this.quantity,
    required this.name,
    required this.total,
    required this.price,
  });

  factory Report.fromMap(Map data) {
    return Report(
      name: data['name'],
      price:  data['price'],
      quantity: data['quantity'],
      total: data['total']

    );
  }
}
