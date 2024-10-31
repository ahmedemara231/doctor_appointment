import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:doctors_appointment/helpers/app_widgets/app_button.dart';
import 'package:doctors_appointment/helpers/base_extensions/context/padding.dart';
import 'package:doctors_appointment/view/book_appointment/screens/date_time.dart';
import 'package:doctors_appointment/view/book_appointment/screens/payment.dart';
import 'package:doctors_appointment/view/book_appointment/screens/summary.dart';
import 'package:doctors_appointment/view/book_appointment/widgets/stepper.dart';
import 'package:doctors_appointment/view_model/home/cubit.dart';
import 'package:doctors_appointment/view_model/home/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../helpers/base_widgets/animated_snack_bar.dart';
import '../../helpers/base_widgets/text.dart';
import 'interface.dart';

class DateAppointment extends StatefulWidget {
  const DateAppointment({super.key});

  @override
  State<DateAppointment> createState() => _DateAppointmentState();
}

class _DateAppointmentState extends State<DateAppointment> {
  List<CheckingValue> appointmentFlow = [
    DateTimeAppointment(),
    Payment(),
    Summary()
  ];

  ValueNotifier<int> currentPage = ValueNotifier(0);
  late PageController controller;

  @override
  void initState() {
    controller = PageController(
        initialPage: currentPage.value,
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
                  physics: const NeverScrollableScrollPhysics(),

                  controller: controller,
                  onPageChanged: (value) {
                    changeValue(value);
                  },
                  itemBuilder: (context, index) => appointmentFlow[index],
                  itemCount: appointmentFlow.length,
                ),
              ),
            ),
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) => AppButton(
                  title: 'Continue',
                  onPressed: () async {
                    if (appointmentFlow[currentPage.value].value == null) {
                        AppSnakeBar.show(
                            context,
                            title: 'Please fill all required fields!',
                            type: AnimatedSnackBarType.error
                        );
                    } else {
                      changeValue(currentPage.value + 1);
                      controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOutSine
                      );
                    }
                  }
              ),
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