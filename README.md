# flutterwave_momo_ghana

A package to process MOMO payments within your  flutter app, currently supporting payments exclusively in Ghana.
To use it, simply call its constructor with the data you wish to submit for the payment. It is a widget with a body and minimal UI
elements. So, treat it like another screen/widget in your app that you send users to when they want to pay.
Collect the payment details from the user whichever way you like. All that matters is that you are calling the constructor with the correct inputs.

## How to use
So you have collected the payment details from the user, and stored it somewhere, could be in your state or from some persistent storage.
When you are ready to initiate a payment, Navigate to this widget by calling its constructor with the named parameters listed below.
The widget handles everything thereafter until the payment is complete assuming correct parameters were passed to it.

## How it works
The transaction takes place in two steps. First, the widget makes a call to the flutterwave api backend and displays a circular progress indicator.
If the details were valid the server will return a url to finish the payment while simultaneously sending an OTP to the user to confirm.
The widget will then redirect the user to a screen to input the OTP code they received. If valid, the transaction is complete and 
your redirect url (if supplied) will receive the transaction details. 

## Important notes
    1. To use this package you must first create a merchant account from flutterwave.com to get you secret key
    
    2. After calling the constructor you must redirect the user (Navigate) to this widget. Otherwise the process will go on alright, 
    but the user cannot see the input box where they need to input their OTP to complete it.
    
    3. Please ensure that you have thouroghly validated the users input making sure that they input a valid 10-digit Ghanaian number, the netword is all caps among others.
    
    4. For the purpose of debugging if error occurs we log it in the console. So if you have issues during development, check the console
    
    5. All inputs are strings, including the phone, and amount. Please do not supply ints
    
## Input params
The constructor accepts several named params some of which are required and others are not. For no required params,
you can omit them entirely. However omitting a single required param will cause you transaction to fail. 

#### amount - required
The amount to charge please modify your settings in flutterwave dashboard to determine who pays for the transaction fee. Transaction fee is the amount you get charged on every  MOMO transaction. You can choose pay or your users are charges extra for that. Whatever is in your settings will be used

#### phone_number - required
This is the phone number connected to the MOMO account you wish to charge. It must be supplied as a 10-digit valid Ghanaian phone number belonging to MTN, Vodafone or AirtelTigo.
Please note that an OTP will be sent to the number you provide (your user).
If the number is not your user's correct number but a valid phone number, then someone else may receive the OTP and your user cannot complete the payment.

#### secret_token - required
The secret key you get from your flutterwave api tab. There is a public key and encryption key. Don't use those use the **secret key**

#### network - required
This is the network provider of the of number you have supplied. Can be one of [MTN, VODAFONE, TIGO] these are the only supported network at this time

#### currency - not required
The currency in which the amount is quoted, default is "GHS". If not supplied, the amount will be interpreted as Ghana Cedi (GHS)
To change it, please look at the flutterwave documentation for the list of currencies supported and their short forms. **DO NOT SUPPLY THE FULL FORM OF THE CURRENCY (Ghana Cedis), JUST THE SHORT FORM ("GHS")**

#### email - not required
Email address of the person making the payment to you. If not given someone@example.com will be used
  
#### transaction_ref - not required
This is the transaction reference you want to assign to this transaction. It must be unique for each transaction. This is useful if you want to track transactions in your app later.
You are free to generate the reference whatever way you choose, using whatever conventions you may have established. If not supplied, we will assign a random reference to each transaction.

#### redirect_url - not required
This is a url and will be verified. If valid the api will send a confirmation  and details of the transaction to this url as **query parameters**. This is useful for cases where 
you want to store details of successful transactions in your database or you want to send confirmation email or text to users about their payments or something similar.
You can designate a url from your own api to receive this data and process it the way you want. Note that api will be making a get request your endpoint.

#### full_name - not required
The name of the person making the payment. It is not required but you can include it so that you know who did the payment

#### sideNote - not required
Any note you would like to add to the transaction. For instance the purpose of the transaction.

## Example code
```
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutterwave_momo_ghana/flutterwave_momo_ghana.dart';
import 'package:flutter/material.dart';

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
      // ASSUMING YOU HAVE A FORM TO COLLECT INFORMATION
        FormField(),
        FormField(),
        FormField(),
        FormField(),

        // WHEN DONE YOU WANT TO INITIATE PAYMENT
        
        FlatButton(
          child: Text("Proceed to pay"),
          
        onPressed: (){
          // validate your form/input source carefully to make sure you have the correct inputs.
          // then redirect the user to the widget by supplying the named params.

          Navigator.of(context).push(
              CupertinoPageRoute(builder: (context) =>
              FlutterwaveGhanaMOMO(amount: amount, phone_number: phone_number, network: network, currency: currency, secret_token: secret_token, redirect_url: redirect_url, email: email, transaction_ref: transaction_ref, full_name: full_name,),
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
