import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'package:hotel_management_system/constants/keys.dart';
import 'package:http/http.dart' as http;

class PaymentGateway {
  static createPaymentIntent({required String amount}) async {
    Map<String, dynamic>? paymentInfo = {
      "amount": amount,
      "currency": "USD",
      "automatic_payment_methods[enabled]": "true",
    };

    var response = await http.post(
      Uri.parse("https://api.stripe.com/v1/payment_intents"),
      body: paymentInfo,
      headers: {
        "Authorization": "Bearer $secretKey",
        "Content-Type": "application/x-www-form-urlencoded"
      },
    );

    print("STRIPE Response:::: ${response.body}");

    return jsonDecode(response.body);
  }

  static Future initPaymentSheet({required String amount}) async {
    try {
      // 1. create payment intent on the server
      final data = await createPaymentIntent(amount: amount);

      // 2. initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
            allowsDelayedPaymentMethods: true,
            paymentIntentClientSecret: data["client_secret"],
            style: ThemeMode.dark,
            merchantDisplayName: "Hotel Booking System"),
      );
      // setState(() {
      //   _ready = true;
      // });
    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Error: $e')),
      // );
      rethrow;
    }
  }
}
