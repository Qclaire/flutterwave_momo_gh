# flutterwave_momo_ghana

## Getting started
The package is a simple tool to process momo payments within your app, currently only supporting payment for Ghana alone.
To use it, simply call its constructor with the data you wish to submit for the payment. It is widget with a body and few UI
elements so treat like another in you app you are displaying. redirect the user to it once they have submitted the data to your form.
The widget will handle every else until the payment is complete assuming correct parameters were passed to it.

The transaction takes place in two steps first, the widget makes a call to the api backend and displays circular progress indicator
If the details were valid the server will return url to finish the payment while simultaneously sending an OTP to the user to confirm.
The widget will then redirect the user to a screen where they input the OTP code they received. If valid the transaction is complete and 
your redirect url will recieve the transaction details. Note that after calling the constructor you must redirect the use to this widget
so they can see the rest of the process.

Below are the details you need to call it:

### amount - required
The amount to charge *(required)* please modify you setting in flutterwave dashboard for who pays for the transaction fee. whatever is in you settings will be used

### phone_number - required
This is the phone number connected to the MOMO account you wish to charge. If must be supplied as a 10-digit valid phone number.
Please not that an OTP will be sent to the number you provide (your user). If the number is wrong but valid, then someone else may receive the OTP and your cannot complete the payment

### secret_token - required
The secret key you get from your flutterwave api tab. There is a public key and encryption key. Don't use those use the *secret key*

### network - required
This is the network provider of the of number you have supplied. Can be one of [MTN, VODAFONE, TIGO] these are the only supported network at this time

### currency - not required
The currency in which the amount is quoted, default is "GHS". If not supplied, the amount will be interpreted as Ghana Cedi (GHS)
To change it, please look at the flutterwave documentation for the list of currencies supported and their short forms. *DO NOT SUPPLY THE FULL FORM OF THE CURRENCY, JUST THE SHORT FORM*

### email - not required
Email address of the person making the payment to you. If not given someone@example.com will be used
  
### transaction_ref - not required
This is the transaction reference you want to assign to this transaction. It must be unique for each transaction. This is useful if you want to track transactions in you app later.
You are free to generate the reference whatever way you choose. If not supplied, we will assign a random reference to each transaction. if not supplied transaction will just terminate at the end

### redirect_url - not required
This is a url and will be verified. If valid the api will send a confirmation of the transaction to this url as query parameters. This is useful for cases where 
you want to store successful transactions in your database or something similar. You can designate a url from your own api to receive this data and process the way want

### full_name - not required
The name of the person you are charging. It is not required but you can include it so that you will know who did the payment