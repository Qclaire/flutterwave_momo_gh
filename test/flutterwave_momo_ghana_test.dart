import 'package:flutter_test/flutter_test.dart';

import 'package:flutterwave_momo_ghana/flutterwave_momo_ghana.dart';
import 'package:flutterwave_momo_ghana/modules/request.dart';

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
  test("Thhe request method should return either null or a url",
      makeRequest(payload: null, headers: null, url: null),
  );

}
