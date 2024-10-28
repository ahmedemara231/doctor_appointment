import 'package:doctors_appointment/helpers/app_widgets/app_button.dart';
import 'package:doctors_appointment/helpers/base_extensions/context/padding.dart';
import 'package:doctors_appointment/view/book_appointment/screens/date_time.dart';
import 'package:doctors_appointment/view/book_appointment/screens/payment.dart';
import 'package:doctors_appointment/view/book_appointment/screens/summary.dart';
import 'package:doctors_appointment/view/book_appointment/widgets/stepper.dart';
import 'package:flutter/material.dart';
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

  int currentPage = 0;

  late PageController controller;

  @override
  void initState() {
    controller  = PageController(initialPage: currentPage);
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
            MyStepper(newStep: currentPage),
            Expanded(
              child: PageView.builder(
                controller: controller,
                  onPageChanged: (value) {
                    currentPage = value;
                    setState(() {});
                  },
                  itemBuilder: (context, index) => appointmentFlow[index],
                  itemCount: appointmentFlow.length,
              ),
            ),
            AppButton(
                title: 'Continue',
                onPressed: () {
                  currentPage++;
                  setState(() {});

                  controller.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOutSine
                  );
                }
            ),
          ],
        ),
      ),
    );
  }
}
