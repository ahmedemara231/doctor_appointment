import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:doctors_appointment/src/core/helpers/base_extensions/context/padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/app_widgets/app_button.dart';
import '../../../../../core/helpers/base_widgets/animated_snack_bar.dart';
import '../../../../../core/helpers/base_widgets/text.dart';
import '../../../blocs/home/cubit.dart';
import '../../../blocs/home/state.dart';
import '../../../blocs/payment/cubit.dart';
import '../../../widgets/book_appointmentwidgets/appointment_type.dart';

class Payment extends StatefulWidget{
  const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> with AutomaticKeepAliveClientMixin{
  final List<String> options = const ['Credit Card', 'PayPal'];

  String? selectedMethod;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MyText(text: 'Payment option', fontWeight: FontWeight.w500),
          ChooseFromAvailableOptions(
            title: 'Payment Method',
            optionsList: options,
            onSelectAppointmentType: (option) {
              context.read<PaymentCubit>().setPaymentMethod(option);
              selectedMethod = option;
            },
          ),
          const Spacer(),
          AppButton(
              title: 'Continue',
              onPressed: () async {
                if(selectedMethod != null){
                  context.read<HomeCubit>().changeCurrentPage(
                      context.read<HomeCubit>().state.currentPage! + 1
                  );
                  context.read<HomeCubit>().makeDoctorAppointmentController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOutSine
                  );
                }else{
                  AppSnakeBar.show(
                      context,
                      title: 'Please fill all required fields!',
                      type: AnimatedSnackBarType.error
                  );
                }
              }
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}