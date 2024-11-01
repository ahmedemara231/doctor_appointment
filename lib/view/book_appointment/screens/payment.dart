import 'package:doctors_appointment/helpers/base_widgets/text.dart';
import 'package:doctors_appointment/view_model/payment/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../interface.dart';
import '../widgets/appointment_type.dart';

class Payment extends StatefulWidget implements CheckingValue{
  Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();

  @override
  var value;
}

class _PaymentState extends State<Payment> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText(text: 'Payment option', fontWeight: FontWeight.w500),
          ChooseFromAvailableOptions(
            title: 'Payment Method',
            optionsList: const <String>['Credit Card', 'PayPal'],
            onSelectAppointmentType: (option) {
              context.read<PaymentCubit>().setPaymentMethod(option);
              widget.value = option;
            },
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}