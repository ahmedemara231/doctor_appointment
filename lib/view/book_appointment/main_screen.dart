import 'package:doctors_appointment/helpers/app_widgets/app_button.dart';
import 'package:doctors_appointment/helpers/base_extensions/context/padding.dart';
import 'package:doctors_appointment/model/local/secure.dart';
import 'package:doctors_appointment/model/remote/stripe/models/payment_intent_model.dart';
import 'package:doctors_appointment/model/remote/stripe/repos/post.dart';
import 'package:doctors_appointment/model/remote/stripe/service/stripe_connection.dart';
import 'package:doctors_appointment/view/book_appointment/screens/date_time.dart';
import 'package:doctors_appointment/view/book_appointment/screens/payment.dart';
import 'package:doctors_appointment/view/book_appointment/screens/summary.dart';
import 'package:doctors_appointment/view/book_appointment/widgets/stepper.dart';
import 'package:doctors_appointment/view_model/stripe/stripe_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../helpers/base_widgets/text.dart';

class DateAppointment extends StatefulWidget {
  const DateAppointment({super.key});

  @override
  State<DateAppointment> createState() => _DateAppointmentState();
}

class _DateAppointmentState extends State<DateAppointment> {
  List<Widget> appointmentFlow = const [
    DateTimeAppointment(),
    Payment(),
    Summary()
  ];

  ValueNotifier<int> currentPage = ValueNotifier(0);
  late PageController controller;

  @override
  void initState() {
    controller = PageController(
        initialPage: currentPage.value
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyText(text: 'Book Appointment'),
      ),
      body: Padding(
        padding: context.horizontalSymmetricPadding(12.w),
        child: Column(
          children: [
            ValueListenableBuilder(
                valueListenable: currentPage,
                builder: (context, value, child) => MyStepper(newStep: value)
            ),
            Expanded(
              child: Padding(
                padding: context.verticalSymmetricPadding(12.h),
                child: PageView.builder(
                  controller: controller,
                  onPageChanged: (value) {
                    changeValue(value);
                  },
                  itemBuilder: (context, index) => appointmentFlow[index],
                  itemCount: appointmentFlow.length,
                ),
              ),
            ),
            AppButton(
                title: 'Continue',
                onPressed: () async{
                  await context.read<StripeCubit>().makePaymentProcess(
                    model: CreateIntentInputModel(
                        amount: (100*100).toString(),
                        currency: 'USD',
                        customerId: await SecureStorage.getInstance().readData(key: 'customerId')??''
                    )
                  );

                  // changeValue(currentPage.value + 1);
                  // controller.nextPage(
                  //     duration: const Duration(milliseconds: 500),
                  //     curve: Curves.easeInOutSine
                  // );
                }
            ),
          ],
        ),
      ),
    );
  }

  void changeValue(int value) {
    currentPage.value = value;
    currentPage.notifyListeners();
  }
}
