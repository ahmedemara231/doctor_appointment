import 'package:doctors_appointment/helpers/base_widgets/text.dart';
import 'package:flutter/material.dart';

import '../widgets/appointment_type.dart';

class Payment extends StatelessWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MyText(text: 'Payment option', fontWeight: FontWeight.w500),
          ChooseFromAvailableOptions(
            title: 'Payment Method',
            optionsList: const <String>['Credit Card', 'PayPal'],
            onSelectAppointmentType: (option) {},
          )
        ],
      ),
    );
  }
}
