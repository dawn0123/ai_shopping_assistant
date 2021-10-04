import 'dart:convert';

import 'package:http/http.dart';

class NetworkHelper {

  NetworkHelper(this.url);

  final String url;

  String cityname="";
  String Province="";

   getData() async{
    Uri myUri = Uri.parse(url);
    Response response = await get(myUri);

    if (response.statusCode == 200){
      String data = response.body;
      cityname = await jsonDecode(data)['data'][1]['label'];
      Province= await jsonDecode(data)['data'][1]['region'];
      print("city name is"+ cityname);
      return cityname;
    }
    else {
      print(response.statusCode);
      return null;

    }
  }
}
