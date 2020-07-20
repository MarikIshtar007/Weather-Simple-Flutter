import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper{
  final String url;
  NetworkHelper({@required this.url});

  Future getData() async{
    http.Response res = await http.get(url);

    if (res.statusCode == 200){
      String data = res.body;
      return jsonDecode(data);
    }
    else{
      print("Error occurred in http response with ${res.statusCode} error code");
    }
  }

}