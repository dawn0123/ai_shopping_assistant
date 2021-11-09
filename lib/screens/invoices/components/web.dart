import 'dart:convert';

import 'package:universal_html/html.dart';

Future<void> saveAndLaunch(List<int> bytes, String filename) async {
  AnchorElement(
      href:
          "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
    ..setAttribute("download", filename)
    ..click();
}
