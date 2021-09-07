import 'dart:typed_data';
import 'package:aishop/screens/cart/components/order_review.dart';
import 'package:aishop/screens/invoices/components/invoice_model.dart';
import 'package:aishop/utils/authentication.dart';
import 'package:aishop/screens/invoices/components/report.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:aishop/screens/invoices/components/web.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

Future<void> createPDF() async {
  final usersList = reportList;
  // create pdf
  PdfDocument document = PdfDocument();

  //Adds page settings
  document.pageSettings.orientation = PdfPageOrientation.portrait;
  document.pageSettings.margins.all = 10;

  // add pages
  PdfPage page = document.pages.add();
  PdfGraphics graphics = page.graphics;

  //Create the header with specific bounds
  PdfPageTemplateElement header = PdfPageTemplateElement(
      Rect.fromLTWH(0, 0, document.pages[0].getClientSize().width, 300));

  // header
  page.graphics.drawString(
      "AI Shopping ", PdfStandardFont(PdfFontFamily.courier, 40),
      bounds: const Rect.fromLTWH(180, 15, 0, 0));

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

  //Draws the heading on the page
  final date = new DateFormat('dd-MM-yyyy');
  PdfLayoutResult result = element.draw(
      page: page, bounds: Rect.fromLTWH(10, bounds.top + 8, 0, 0))!;
  String currentDate = 'DATE ' + date.format(DateTime.now());

  //Measures the width of the text to place it in the correct location
  Size textSize = subHeadingFont.measureString(currentDate);
  Offset textPosition = Offset(
      graphics.clientSize.width - textSize.width - 10, result.bounds.top);

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

  element =
      PdfTextElement(text: name.toString().toUpperCase(), font: helvetica);
  element.brush = PdfBrushes.black;
  result = element.draw(
      page: page, bounds: Rect.fromLTWH(10, result.bounds.bottom + 10, 0, 0))!;

  element = PdfTextElement(text: userEmail.toString(), font: helvetica);
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
  grid.columns.add(count: 4);

//Add header to the grid
  grid.headers.add(1);

//Set values to the header cells
  PdfGridRow headerz = grid.headers[0];
  // headerz.cells[0].value = 'Product Id';
  headerz.cells[0].value = 'Product Name';
  headerz.cells[1].value = 'Price';
  headerz.cells[2].value = 'Quantity';
  headerz.cells[3].value = 'Total';

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
  //Iterate users list and generate PDF grid rows.
  for (int i = 0; i < usersList.length; i++) {
    PdfGridRow row = grid.rows.add();
    //Get the user report.
    Report report = usersList[i];
    row.cells[0].value = report.name;
    row.cells[1].value = report.price;
    row.cells[2].value = report.quantity;
    row.cells[3].value = report.total;
  }

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
      'Grand Total :              \R $orderTotal', subHeadingFont,
      brush: PdfSolidBrush(PdfColor(0, 0, 0)),
      bounds: Rect.fromLTWH(360, gridResult.bounds.bottom + 30, 0, 0));

  gridResult.page.graphics.drawString(
      'Thank you shopping for with us !', subHeadingFont,
      brush: PdfBrushes.black,
      bounds: Rect.fromLTWH(360, gridResult.bounds.bottom + 60, 0, 0));

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

// image
Future<Uint8List> _readImageData(String name) async {
  final data = await rootBundle.load('assets/images/$name');
  return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
}
