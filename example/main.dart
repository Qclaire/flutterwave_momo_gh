import 'package:flutter/cupertino.dart';
import 'package:flutterwave_momo_ghana/flutterwave_momo_ghana.dart';
import 'package:flutter/material.dart';

class FlutterwaveMOMOGhanaExampleClass extends StatefulWidget {
  @override
  _FlutterwaveMOMOGhanaExampleClassState createState() => _FlutterwaveMOMOGhanaExampleClassState();
}

class _FlutterwaveMOMOGhanaExampleClassState extends State<FlutterwaveMOMOGhanaExampleClass> {
  String amount = "10";
  String secretToken = "Your-secret-token-here";
  String currency = "GHS";
  String email = "someone@example.com";
  String transactionRef = "some-reference-number-you generated";
  String phoneNumber= "valid-ghanaian-phone-number";
  String network = "MTN | VODAFONE | TIGO";
  String redirectUrl = "your-magic-api-link";
  String fullName = "Fellow Ghanaian";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      // YOUR INPUT COMPONENTS GO HERE TO COLLECT THE INFORMATION YOU NEED
        TextField(),
        TextField(),
        TextField(),
        TextField(),


        FlatButton(
          child: Text("Proceed to pay"),
          onPressed: (){
          // validate you form input to make sure you have the correct inputs
          // then redirect the user to the widget inputing the correct data
          Navigator.of(context).push(
              CupertinoPageRoute(builder: (context) =>
              FlutterwaveGhanaMOMO(amount: amount, phoneNumber: phoneNumber, network: network, currency: currency, secretToken: secretToken, redirectUrl: redirectUrl, email: email, transactionRef: transactionRef, fullName: fullName,),
              ),
          );
          //
        }
        ,)

      ],
      //
    );
  }
}
