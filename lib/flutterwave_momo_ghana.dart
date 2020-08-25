library flutterwave_momo_ghana;

import 'package:flutter/material.dart';
import 'package:flutterwave_momo_ghana/src/request.dart';
import 'package:uuid/uuid.dart';
import 'package:webview_flutter/webview_flutter.dart';


class FlutterwaveGhanaMOMO extends StatefulWidget {
  final String amount;
  final String secret_token;
  String currency = "GHS";
  String email = "someone@example.com";
  String transaction_ref = Uuid().v4();
  final String phone_number;
  final String network;
  String redirect_url;
  String full_name;
  String momoURL = "https://api.flutterwave.com/v3/charges?type=mobile_money_ghana";

  FlutterwaveGhanaMOMO({
    @required this.amount,
    @required this.phone_number,
    @required this.network,
    @required this.secret_token,
    this.currency,
    this.redirect_url,
    this.email,
    this.transaction_ref,
    this.full_name,
  });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

}
class _FlutterwaveGhanaMOMOState extends State<FlutterwaveGhanaMOMO> {
  bool isBusy = true;
  String redirectURL = "";
  var isSuccess;


  @override
  void initState() {
    super.initState();
    request();
  }
  request()async{
    Map<String, String> payload = {"amount":widget.amount, "currency":widget.currency, "email":widget.email, "tx_rf":widget.transaction_ref, "network":widget.network, "phone_number":widget.phone_number};
    Map<String, String> hearders = {"Authorization": "Bearer ${widget.secret_token}"};
    var status = await makeRequest(payload: payload, headers: hearders, url: widget.momoURL);
    if(status !=  null){
      setState(() {
        isSuccess = true;
        redirectURL = status;
      });
    }else{
      setState(() {
        isSuccess = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ViewSelector(isBusy: isBusy, isSuccess: isSuccess, redirectURL: redirectURL);
  }


}

class ViewSelector extends StatelessWidget {
  const ViewSelector({
    Key key,
    @required this.isBusy,
    @required this.isSuccess,
    @required this.redirectURL,
  }) : super(key: key);

  final bool isBusy;
  final bool isSuccess;
  final String redirectURL;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: SafeArea(
          child: isBusy == true && isSuccess == null ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(strokeWidth: 8,),
                SizedBox(height: 15,),
                Text("Processing your payment...", ),
              ],
            ),
          )
              :
          isBusy == false && isSuccess == true ?
          WebView(initialUrl:redirectURL, javascriptMode: JavascriptMode.unrestricted,)
              :
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.sms_failed, size:100, color: Colors.deepOrange,),
                SizedBox(height: 15,),
                Text("Transaction failed"),
              ],
            ),
          ),
        )
    );
  }
}

