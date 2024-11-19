import 'package:doctors_appointment/src/core/helpers/base_extensions/context/padding.dart';
import 'package:doctors_appointment/src/features/home/screens/book_appointment/screens/summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/base_widgets/text.dart';
import '../../../blocs/home/cubit.dart';
import '../../../blocs/home/state.dart';
import '../../../widgets/book_appointmentwidgets/stepper.dart';
import '../screens/date_time.dart';
import '../screens/payment.dart';

class MakeAppointment extends StatefulWidget {
  const MakeAppointment({super.key});

  @override
  State<MakeAppointment> createState() => _MakeAppointmentState();
}

class _MakeAppointmentState extends State<MakeAppointment> {
  List<Widget> appointmentFlow = const [
    DateTimeAppointment(),
    Payment(),
    Summary()
  ];

  @override
  void initState() {
    context.read<HomeCubit>().makeDoctorAppointmentController = PageController();
    context.read<HomeCubit>().changeCurrentPage(0);
    super.initState();
  }

  @override
  void dispose() {
    context.read<HomeCubit>().makeDoctorAppointmentController.dispose();
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
                  controller: context.read<HomeCubit>().makeDoctorAppointmentController,
                  itemBuilder: (context, index) => appointmentFlow[index],
                  itemCount: appointmentFlow.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}