import 'package:doctors_appointment/constants/app_constants.dart';
import 'package:doctors_appointment/helpers/app_widgets/app_button.dart';
import 'package:doctors_appointment/helpers/base_extensions/context/padding.dart';
import 'package:doctors_appointment/helpers/base_widgets/text.dart';
import 'package:doctors_appointment/view/book_appointment/widgets/date_picker.dart';
import 'package:doctors_appointment/view/error_builder/screen.dart';
import 'package:doctors_appointment/view_model/home/cubit.dart';
import 'package:doctors_appointment/view_model/home/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DateTimeAppointment extends StatefulWidget {
  const DateTimeAppointment({super.key});

  @override
  State<DateTimeAppointment> createState() => _DateTimeAppointmentState();
}

class _DateTimeAppointmentState extends State<DateTimeAppointment> {
  final List<String> _times = ['8:00 AM','9:30 AM', '10:00 AM', '11:00 AM', '12:00 PM', '1:00 PM'];

  @override
  void initState() {
    context.read<HomeCubit>().getAvailableTimes();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: MyText(text: 'Book Appointment'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                MyText(text: 'Select Date', fontWeight: FontWeight.w500,),
                const Spacer(),
                TextButton(
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 14)),
                      ).then((value) {});
                    },
                    child: MyText(text: 'Set Manual', color: Constants.appColor,)
                )

              ],
            ),
            MyDatePicker(
              onSelect: (selectedDate) =>
                  context.read<HomeCubit>().getAvailableTimes(),
            ),
            Padding(
              padding: context.verticalSymmetricPadding(16.h),
              child: MyText(text: 'Available time', fontWeight: FontWeight.w500,),
            ),
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) => Expanded(
                child: Skeletonizer(
                  enabled: state.currentState == States.getAvailableTimesLoading,
                  child: state.currentState == States.getAvailableTimesError?
                  ErrorBuilder(
                      msg: 'Try Again Later',
                      onPressed: () => context.read<HomeCubit>().getAvailableTimes(),
                  ) :
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 3,
                        mainAxisSpacing: 12.h,
                        crossAxisSpacing: 12.w,
                        crossAxisCount: 2
                    ),
                    itemBuilder: (context, index) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                        border: Border.all(
                            color: state.currentIndexTime == index?
                            Colors.grey : Colors.white,
                            width: 3
                        ),
                      ),
                      child: AppButton(
                        title: _times[index],
                        onPressed: state.availableTimes!.contains(_times[index])?
                            () {
                          context.read<HomeCubit>().selectTime(index);
                        } : null,
                      ),
                    ),
                    itemCount: 6,
                  ),
                ),
              ),
            )
          ],
        ),
    );
  }
}