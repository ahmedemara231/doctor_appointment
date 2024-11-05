import 'dart:developer';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:doctors_appointment/helpers/app_widgets/app_button.dart';
import 'package:doctors_appointment/helpers/base_extensions/context/padding.dart';
import 'package:doctors_appointment/helpers/base_extensions/context/routes.dart';
import 'package:doctors_appointment/view/book_appointment/main/paymentSuccess.dart';
import 'package:doctors_appointment/view/book_appointment/main/payment_error.dart';
import 'package:doctors_appointment/view/book_appointment/screens/date_time.dart';
import 'package:doctors_appointment/view/book_appointment/screens/payment.dart';
import 'package:doctors_appointment/view/book_appointment/screens/summary.dart';
import 'package:doctors_appointment/view/book_appointment/widgets/stepper.dart';
import 'package:doctors_appointment/view_model/home/cubit.dart';
import 'package:doctors_appointment/view_model/home/state.dart';
import 'package:doctors_appointment/view_model/payment/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../helpers/base_widgets/animated_snack_bar.dart';
import '../../../helpers/base_widgets/text.dart';
import '../../../helpers/data_types/appointment_details.dart';
import '../interface.dart';

class MakeAppointment extends StatefulWidget {
  const MakeAppointment({super.key});

  @override
  State<MakeAppointment> createState() => _MakeAppointmentState();
}

class _MakeAppointmentState extends State<MakeAppointment> {
  List<CheckingValue> appointmentFlow = [
    DateTimeAppointment(),
    Payment(),
    Summary()
  ];

  late PageController controller;

  @override
  void initState() {
    controller = PageController();
    context.read<HomeCubit>().changeCurrentPage(0);
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
        title: const MyText(text: 'Book Appointment'),
      ),
      body: Padding(
        padding: context.horizontalSymmetricPadding(12.w),
        child: Column(
          children: [
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                return MyStepper(newStep: state.currentPage!);
              },
            ),
            Expanded(
              child: Padding(
                padding: context.verticalSymmetricPadding(12.h),
                child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: controller,
                  itemBuilder: (context, index) => appointmentFlow[index],
                  itemCount: appointmentFlow.length,
                ),
              ),
            ),
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) =>
                  BlocListener<PaymentCubit, PaymentState>(
                    listener: (context, state) async{
                      switch(state.currentState){
                        case PaymentStates.makePaymentProcessSuccess:
                          context.replacementRoute(const PaymentSuccess());

                        case PaymentStates.makePaymentProcessError:
                          context.replacementRoute(const PaymentError());

                        default:
                          return;
                      }
                    },
                    child: Padding(
                      padding: context.verticalSymmetricPadding(10.h),
                      child: AppButton(
                          title: state.currentPage != 2? 'Continue' : 'Pay',
                          onPressed: () async {
                            switch(appointmentFlow[state.currentPage!].mainValue){
                              case null:
                                AppSnakeBar.show(
                                    context,
                                    title: 'Please fill all required fields!',
                                    type: AnimatedSnackBarType.error
                                );
                              default:
                                switch(state.currentPage){
                                  case 2:
                                    final details = UserAppointmentDetails(
                                      appointmentDate: state.appointmentDate!,
                                      appointmentTime: state.appointmentTime!,
                                      appointmentType: state.appointmentType!,
                                    );
                                    context.read<PaymentCubit>().pay(
                                        context,
                                        amount: 100,
                                        details: details
                                    );
                                    // context.read<HomeCubit>().makeAppointment();

                                  default:
                                    context.read<HomeCubit>().changeCurrentPage(
                                        state.currentPage! + 1
                                    );
                                    controller.nextPage(
                                        duration: const Duration(milliseconds: 500),
                                        curve: Curves.easeInOutSine
                                    );
                                }
                            }
                          }
                      ),
                    ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}