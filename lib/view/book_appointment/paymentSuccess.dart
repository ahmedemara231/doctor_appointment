import 'package:doctors_appointment/helpers/base_widgets/text.dart';
import 'package:flutter/material.dart';

class PaymentSuccess extends StatelessWidget {
  const PaymentSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyText(text: 'Payment Successful!'),
    );
  }
}
