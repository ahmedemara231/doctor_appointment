import 'package:doctors_appointment/helpers/base_widgets/text.dart';
import 'package:flutter/material.dart';

class Payment extends StatelessWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyText(text: 'Payment Page'),
    );
  }
}
