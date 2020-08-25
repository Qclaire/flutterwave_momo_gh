import 'package:flutter_test/flutter_test.dart';

import 'package:flutterwave_momo_ghana/src/request.dart';

void main() {
  Map<String, String> payload = {
    "tx_ref":"MC-158523s09v5050e8",
  "amount":"1",
  "currency":"GHS",
  "network":"MTN",
  "email":"user@gmail.com",
  "phone_number":"0547099292",
  "fullname":"John Madakin",
  };
  Map<String,String> headers = {"Authorization": "Bearer FLWSECK_TEST-SANDBOXDEMOKEY-X"};
  String url = "https://api.flutterwave.com/v3/charges?type=mobile_money_ghana";
  
  test("The request method should return either null or a url",
      makeRequest(payload: payload, headers: headers, url: url),
  );

}
