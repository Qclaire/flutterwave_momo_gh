import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

dynamic makeRequest({@required Map<String, String> payload, @required Map<String, String> headers, @required String url})async{

  var resp = await http.post(url, headers: headers, body:payload);
  var statusCode = resp.statusCode;
  var message = jsonDecode(resp.body)["message"];
  var status = jsonDecode(resp.body)["status"];

  if(statusCode == 200 && status == "success") {
      String redirectURL = jsonDecode(resp.body)["meta"]["authorization"]["redirect"];
      return redirectURL;
  }else{
    print(
        "\n///////////////////////////////////////////////\n"
            "Status Code: $statusCode\n"
            "Status: $status\n"
            "Error Message: $message"
        "\n///////////////////////////////////////////////\n"
    );
    return null;

  }
}