library flutterwave_momo_ghana;

import 'package:flutter/material.dart';
import 'package:flutterwave_momo_ghana/src/request.dart';
import 'package:uuid/uuid.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FlutterwaveGhanaMOMO extends StatefulWidget {
  final String amount;
  final String secretToken;
  final String currency;
  final String email;
  final String transactionRef;
  final String phoneNumber;
  final String network;
  final String redirectUrl;
  final String fullName;
  final String sideNote;

  FlutterwaveGhanaMOMO({
    @required this.amount,
    @required this.phoneNumber,
    @required this.network,
    @required this.secretToken,
    this.currency = "GHS",
    this.redirectUrl,
    this.email = "someone@example.com",
    this.transactionRef,
    this.fullName,
    this.sideNote,
  });

  @override
  _FlutterwaveGhanaMOMOState createState() => _FlutterwaveGhanaMOMOState();

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
    var ref = widget.transactionRef == null ? Uuid().v4() :widget.transactionRef;
    Map<String, String> payload = {"amount":widget.amount, "currency":widget.currency, "email":widget.email, "tx_rf":ref, "network":widget.network, "phone_number":widget.phoneNumber, "redirect_url":widget.redirectUrl, "fullname":widget.fullName,"sideNote":widget.sideNote};
    Map<String, String> headers = {"Authorization": "Bearer ${widget.secretToken}"};
    String momoURL = "https://api.flutterwave.com/v3/charges?type=mobile_money_ghana";

    var status = await makeRequest(payload: payload, headers: headers, url:momoURL);
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

