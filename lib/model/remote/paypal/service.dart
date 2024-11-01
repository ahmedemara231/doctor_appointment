import 'dart:developer';
import 'package:doctors_appointment/helpers/base_extensions/context/routes.dart';
import 'package:doctors_appointment/model/remote/paypal/paypal_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'models/amount.dart';

class PaypalService {
  Future<void> makePaypalPaymentProcess(BuildContext context,{required int amount})async {
    AmountModel amountModel = AmountModel(
      total: amount.toString(),
    );

    context.normalNewRoute(PaypalCheckoutView(
      sandboxMode: true,
      clientId: PaypalConstants.paypalClientId,
      secretKey: PaypalConstants.secretKey,
      transactions: [
        {
          "amount": amountModel.toJson(),
          "description": "MediMeet Doctors Appointment",
          "item_list": const {
            "items": []
          }
        }
      ],
      note: "Contact us for any questions on your order.",
      onSuccess: (Map params) async {
        log("onSuccess: $params");
        Navigator.pop(context);
      },
      onError: (error) {
        log("onError: $error");
        Navigator.pop(context);
      },
      onCancel: () {
        log('cancelled:');
        Navigator.pop(context);
      },
    ));
  }
}