// maps names to values
class Report {
  String invoiceID;
  String date;
  String address;
  double total;

  Report({
    required this.invoiceID,
    required this.date,
    required this.address,
    required this.total,
  });

  factory Report.fromMap(Map data) {
    return Report(
        invoiceID: data['invoiceID'],
        date: data['date'],
        address:  data['address'],
        total: data['total']
    );
  }
}
