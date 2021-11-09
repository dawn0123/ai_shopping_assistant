import 'package:aishop/screens/invoices/components/web.dart';
import 'package:aishop/utils/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

Future<void> createPDF({required String invoiceID}) async {
  // create pdf
  PdfDocument document = PdfDocument();

  //Adds page settings
  document.pageSettings.orientation = PdfPageOrientation.portrait;
  document.pageSettings.margins.all = 10;

  // add pages
  PdfPage page = document.pages.add();
  PdfGraphics graphics = page.graphics;

  ByteData data = await rootBundle.load("assets/images/default.jpg");
  page.graphics.drawImage(PdfBitmap(await data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes)),
      Rect.fromLTWH((page.size.width/2)-75, 0, 150, 150));

  // header
  /*page.graphics.drawString(
      "AI Shopping ", PdfStandardFont(PdfFontFamily.courier, 40),
      bounds: const Rect.fromLTWH(180, 15, 0, 0));*/

  page.graphics.drawString(
      "AI Shopping (Pty) Ltd ", PdfStandardFont(PdfFontFamily.helvetica, 13),
      bounds: const Rect.fromLTWH(10, 70, 0, 0));

  graphics.drawString(
      "www.aishopping.com ", PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: const Rect.fromLTWH(10, 88, 0, 0));

  graphics.drawString(
      "Tel No: 012 000 0000", PdfStandardFont(PdfFontFamily.helvetica, 8),
      bounds: const Rect.fromLTWH(10, 103, 0, 0));

  //Draws a rectangle to place the heading in that region
  PdfBrush solidBrush = PdfSolidBrush(PdfColor(0, 0, 0));
  Rect bounds = Rect.fromLTWH(0, 130, graphics.clientSize.width, 30);
  graphics.drawRectangle(brush: solidBrush, bounds: bounds);

  //Creates a font for adding the heading in the page
  PdfFont subHeadingFont = PdfStandardFont(PdfFontFamily.helvetica, 14);

  // //Creates a text element to add the invoice number
  PdfTextElement element =
  PdfTextElement(text: 'TAX INVOICE ', font: subHeadingFont);
  element.brush = PdfBrushes.white;

  double tots = 0;
  double delivery = 0;
  var invoiceDate;
  String address = "";
  String deliveryMethod = "";

  await FirebaseFirestore.instance.collection("Users").doc(uid).collection("Invoices")
      .doc(invoiceID).get().then((value){
    delivery = value.get("delivery cost");
    tots = value.get("invoice total");
    invoiceDate = value.get("date");
    address = value.get("address");
    deliveryMethod = value.get("default delivery");
  });

  double grandTotal = tots;
  tots = tots - delivery;


  //Draws the heading on the page
  final date = new DateFormat('dd-MM-yyyy');
  PdfLayoutResult result = element.draw(
      page: page, bounds: Rect.fromLTWH(10, bounds.top + 8, 0, 0))!;
  String currentDate = 'DATE ' + date.format(invoiceDate.toDate());

  //Measures the width of the text to place it in the correct location
  Size textSize = subHeadingFont.measureString(currentDate);

  //Draws the date by using drawString method
  graphics.drawString(currentDate, subHeadingFont,
      brush: element.brush,
      bounds: Offset(graphics.clientSize.width - textSize.width - 10,
          result.bounds.top) &
      Size(textSize.width + 2, 20));

  //Creates text elements to add the address and draw it to the page
  element = PdfTextElement(
      text: 'BILLED TO ',
      font: PdfStandardFont(PdfFontFamily.helvetica, 13,
          style: PdfFontStyle.bold));
  element.brush = PdfSolidBrush(PdfColor(0, 0, 0));
  result = element.draw(
      page: page, bounds: Rect.fromLTWH(10, result.bounds.bottom + 15, 0, 0))!;

  PdfFont helvetica =
  PdfStandardFont(PdfFontFamily.helvetica, 10, style: PdfFontStyle.bold);

  String n = "";
  await FirebaseFirestore.instance.collection("Users").doc(uid).collection("info")
      .doc(uid).get().then((value){
    n = value.get("fname")+" "+value.get("lname");
  });

  element =
      PdfTextElement(text: n.toUpperCase(), font: helvetica);
  element.brush = PdfBrushes.black;
  result = element.draw(
      page: page, bounds: Rect.fromLTWH(10, result.bounds.bottom + 10, 0, 0))!;

  element = PdfTextElement(text: userEmail.toString(), font: helvetica);
  element.brush = PdfBrushes.black;
  result = element.draw(
      page: page, bounds: Rect.fromLTWH(10, result.bounds.bottom + 10, 0, 0))!;

  element = PdfTextElement(text: address.toString(), font: helvetica);
  element.brush = PdfBrushes.black;
  result = element.draw(
      page: page, bounds: Rect.fromLTWH(10, result.bounds.bottom + 10, 0, 0))!;

  element = PdfTextElement(text: deliveryMethod.toString(), font: helvetica);
  element.brush = PdfBrushes.black;
  result = element.draw(
      page: page, bounds: Rect.fromLTWH(10, result.bounds.bottom + 10, 0, 0))!;

  //Draws a line at the bottom of the address
  graphics.drawLine(
      PdfPen(PdfColor(0, 0, 0), width: 1),
      Offset(0, result.bounds.bottom + 3),
      Offset(graphics.clientSize.width, result.bounds.bottom + 3));

  //Creates a PDF grid
  PdfGrid grid = PdfGrid();

//Add the columns to the grid
  grid.columns.add(count: 6);

//Add header to the grid
  grid.headers.add(1);

//Set values to the header cells
  PdfGridRow headerz = grid.headers[0];
  // headerz.cells[0].value = 'Product Id';
  headerz.cells[0].value = 'Product ID';
  headerz.cells[1].value = 'Name';
  headerz.cells[2].value = 'Category';
  headerz.cells[3].value = 'Qty';
  headerz.cells[4].value = 'Unit price';
  headerz.cells[5].value = 'Total';

//Creates the header style
  PdfGridCellStyle headerStyle = PdfGridCellStyle();
  headerStyle.borders.all = PdfPen(PdfColor(131, 130, 136));
  headerStyle.backgroundBrush = PdfSolidBrush(PdfColor(131, 130, 136));
  headerStyle.textBrush = PdfBrushes.white;
  headerStyle.font =
      PdfStandardFont(PdfFontFamily.helvetica, 14, style: PdfFontStyle.regular);

//Adds cell customizations
  for (int i = 0; i < headerz.cells.count; i++) {
    if (i == 0 || i == 1) {
      headerz.cells[i].stringFormat = PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle);
    } else {
      headerz.cells[i].stringFormat = PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle);
    }
    headerz.cells[i].style = headerStyle;
  }

  //Set the width
  grid.columns[3].width = 30;
//Create and customize the string formats
  PdfStringFormat format = PdfStringFormat();
  format.alignment = PdfTextAlignment.right;
  format.lineAlignment = PdfVerticalAlignment.middle;

//Set the column text format
  grid.columns[3].format = format;
  grid.columns[4].format = format;
  grid.columns[5].format = format;

  QuerySnapshot list = await FirebaseFirestore.instance.collection("Users").doc(uid).collection("Invoices")
      .doc(invoiceID).collection("products").get();
  List<DocumentSnapshot> documents = list.docs;

//Iterate users list and generate PDF grid rows.
  documents.forEach((element) {
    print(element.id);
    PdfGridRow row = grid.rows.add();
    row.cells[0].value = element.id;
    row.cells[1].value = element.get("name");
    row.cells[2].value = element.get("category");
    row.cells[3].value = element.get("quantity").toString();
    row.cells[4].value = "R "+element.get("price").toStringAsFixed(2);
    row.cells[5].value = "R "+(element.get("quantity")*element.get("price")).toStringAsFixed(2);
  });

//Set padding for grid cells
  grid.style.cellPadding = PdfPaddings(left: 2, right: 2, top: 2, bottom: 2);

//Creates the grid cell styles
  PdfGridCellStyle cellStyle = PdfGridCellStyle();
  cellStyle.borders.all = PdfPens.white;
  cellStyle.borders.bottom = PdfPen(PdfColor(65, 65, 65), width: 0.70);
  cellStyle.font = PdfStandardFont(PdfFontFamily.helvetica, 12);
  cellStyle.textBrush = PdfSolidBrush(PdfColor(0, 0, 0));
//Adds cell customizations
  for (int i = 0; i < grid.rows.count; i++) {
    PdfGridRow row = grid.rows[i];
    for (int j = 0; j < row.cells.count; j++) {
      row.cells[j].style = cellStyle;
      if (j == 0) {
        row.cells[j].stringFormat = PdfStringFormat(
            alignment: PdfTextAlignment.left,
            lineAlignment: PdfVerticalAlignment.middle);
      } else if (j == 1) {
        row.cells[j].stringFormat = PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.middle);
      } else {
        row.cells[j].stringFormat = PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.middle);
      }
    }
  }

//Creates layout format settings to allow the table pagination
  PdfLayoutFormat layoutFormat =
  PdfLayoutFormat(layoutType: PdfLayoutType.paginate);

//Draws the grid to the PDF page
  PdfLayoutResult gridResult = grid.draw(
      page: page,
      bounds: Rect.fromLTWH(0, result.bounds.bottom + 20,
          graphics.clientSize.width, graphics.clientSize.height - 100),
      format: layoutFormat)!;

  gridResult.page.graphics.drawString(
      'Subtotal :               \R '+ tots.toStringAsFixed(2), PdfStandardFont(PdfFontFamily.helvetica, 13),
      brush: PdfSolidBrush(PdfColor(0, 0, 0)),
      bounds: Rect.fromLTWH(380, gridResult.bounds.bottom + 30, 0, 0));

  gridResult.page.graphics.drawString(
      'Delivery :                   \R '+ delivery.toStringAsFixed(2), PdfStandardFont(PdfFontFamily.helvetica, 13),
      brush: PdfSolidBrush(PdfColor(0, 0, 0)),
      bounds: Rect.fromLTWH(380, gridResult.bounds.bottom + 60, 0, 0));

  graphics.drawLine(
      PdfPen(PdfColor(0, 0, 0), width: 0.6),
      Offset(360, gridResult.bounds.bottom+80),
      Offset(graphics.clientSize.width, gridResult.bounds.bottom +80));

  graphics.drawLine(
      PdfPen(PdfColor(0, 0, 0), width: 0.6),
      Offset(360, gridResult.bounds.bottom+83),
      Offset(graphics.clientSize.width, gridResult.bounds.bottom +83));

  gridResult.page.graphics.drawString(
      'Grand Total :           \R '+ grandTotal.toStringAsFixed(2), subHeadingFont,
      brush: PdfSolidBrush(PdfColor(0, 0, 0)),
      bounds: Rect.fromLTWH(360, gridResult.bounds.bottom + 90, 0, 0));

  graphics.drawLine(
      PdfPen(PdfColor(0, 0, 0), width: 0.5),
      Offset(360, gridResult.bounds.bottom +110),
      Offset(graphics.clientSize.width, gridResult.bounds.bottom +110));

  gridResult.page.graphics.drawString(
      'Thank you shopping for with us !', subHeadingFont,
      brush: PdfBrushes.black,
      bounds: Rect.fromLTWH(360, gridResult.bounds.bottom + 120, 0, 0));

  // draw image
  // page.graphics.drawImage(
  //     PdfBitmap(File('assets/images/cover.png').readAsBytesSync()),
  //     Rect.fromLTWH(0, 0, 100, 100));
  // page.graphics.drawImage(PdfBitmap(await _readImageData("cover.png")),
  //     Rect.fromLTWH(0, 100, 300, 200));

  // grid.draw(page: document.pages.add());

  List<int> bytes = document.save();
  document.dispose();

  saveAndLaunch(bytes, "Invoice.pdf");
}
