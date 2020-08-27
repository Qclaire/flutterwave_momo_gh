```
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutterwave_momo_ghana/flutterwave_momo_ghana.dart';


class FlutterwaveMOMOGhanaExampleClass extends StatefulWidget {
  @override
  _FlutterwaveMOMOGhanaExampleClassState createState() => _FlutterwaveMOMOGhanaExampleClassState();
}

class _FlutterwaveMOMOGhanaExampleClassState extends State<FlutterwaveMOMOGhanaExampleClass> {
  String amount = "10";
  String secret_token = "Your-secret-token-here";
  String currency = "GHS";
  String email = "someone@example.com";
  String transaction_ref = "some-reference-number-you generated";
  String phone_number= "valid-ghanaian-phone-number";
  String network = "MTN | VODAFONE | TIGO";
  String redirect_url = "your-magic-api-link";
  String full_name = "Fellow Ghanaian";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      // YOUR INPUT COMPONENTS GO HERE TO COLLECT THE INFORMATION YOU NEED
        FormField(),
        FormField(),
        FormField(),
        FormField(),

        FlatButton(
          child: Text("Proceed to pay"),
          onPressed: (){
          // validate you form input to make sure you have the correct inputs
          // then redirect the user to the widget inputing the correct data
          Navigator.of(context).push(
              CupertinoPageRoute(builder: (context) =>
              FlutterwaveGhanaMOMO(amount: amount, phoneNumber: phone_number, network: network, currency: currency, secretToken: secret_token, redirectUrl: redirect_url, email: email, transactionRef: transaction_ref, fullName: full_name,),
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
```