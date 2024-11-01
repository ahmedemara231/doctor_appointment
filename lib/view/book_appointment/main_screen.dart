import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:doctors_appointment/helpers/app_widgets/app_button.dart';
import 'package:doctors_appointment/helpers/base_extensions/context/padding.dart';
import 'package:doctors_appointment/helpers/base_extensions/context/routes.dart';
import 'package:doctors_appointment/view/book_appointment/paymentSuccess.dart';
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
import '../../model/local/secure.dart';
import '../../model/remote/stripe/models/payment_intent_model.dart';
import '../../view_model/stripe/stripe_cubit.dart';
import 'interface.dart';

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

  // ValueNotifier<int> currentPage = ValueNotifier(0);
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
        title: MyText(text: 'Book Appointment'),
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
                  AppButton(
                      title: state.currentPage != 2? 'Continue' : 'Pay',

                      onPressed: () async {
                        switch(appointmentFlow[state.currentPage!].value){
                          case null:
                            AppSnakeBar.show(
                                context,
                                title: 'Please fill all required fields!',
                                type: AnimatedSnackBarType.error
                            );
                          default:
                            switch(state.currentPage){
                              case 2:
                                context.read<StripeCubit>().makePaymentProcess(
                                    model: CreateIntentInputModel(
                                        amount: 100.toString(),
                                        currency: 'USD',
                                        customerId: await SecureStorage.getInstance().readData(key: 'customerId') as String
                                    )
                                ).then((value) {
                                  context.replacementRoute(const PaymentSuccess());
                                  // context.read<HomeCubit>().confirmAppointment();
                                });
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
          ],
        ),
      ),
    );
  }
}