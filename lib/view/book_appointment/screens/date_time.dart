import 'package:doctors_appointment/helpers/app_widgets/app_button.dart';
import 'package:doctors_appointment/helpers/base_extensions/context/mediaQuery.dart';
import 'package:doctors_appointment/helpers/base_extensions/context/padding.dart';
import 'package:doctors_appointment/helpers/base_widgets/text.dart';
import 'package:doctors_appointment/view/book_appointment/interface.dart';
import 'package:doctors_appointment/view/book_appointment/widgets/date_picker.dart';
import 'package:doctors_appointment/view/error_builder/screen.dart';
import 'package:doctors_appointment/view_model/home/cubit.dart';
import 'package:doctors_appointment/view_model/home/state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../widgets/appointment_type.dart';


class DateTimeAppointment extends StatefulWidget implements CheckingValue{
  DateTimeAppointment({super.key});

  @override
  State<DateTimeAppointment> createState() => _DateTimeAppointmentState();

  @override
  var value;
}

class _DateTimeAppointmentState extends State<DateTimeAppointment> with AutomaticKeepAliveClientMixin {
  final List<String> _times = ['8:00 AM','9:30 AM', '10:00 AM', '11:00 AM', '12:00 PM', '1:00 PM'];

  @override
  void initState() {
    context.read<HomeCubit>().getAvailableTimes();
    super.initState();
  }

  DateTime? _selectedDate;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView(
      children: [
        MyDatePicker(
            onSelect: (selectedDate) {
              context.read<HomeCubit>().changeAppointmentDate(
                  DateFormat("d-M-yyyy").format(selectedDate)
              );
              context.read<HomeCubit>().getAvailableTimes(
                time: selectedDate
              );
            }
        ),
        Padding(
          padding: context.verticalSymmetricPadding(16.h),
          child: MyText(text: 'Available time', fontWeight: FontWeight.w500,),
        ),
        BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) => SizedBox(
            height: context.setHeight(3),
            child: Skeletonizer(
              enabled: state.currentState == States.getAvailableTimesLoading,
              child: state.currentState == States.getAvailableTimesError?
              ErrorBuilder(
                msg: 'Try Again Later',
                onPressed: () => context.read<HomeCubit>().getAvailableTimes(),
              ) :
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
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
                      context.read<HomeCubit>().changeAppointmentTime(_times[index]);
                      widget.value = _times[index];
                      context.read<HomeCubit>().selectTime(index);
                    } : null,
                  ),
                ),
                itemCount: _times.length,
              ),
            ),
          ),
        ),
        ChooseFromAvailableOptions(
          title: 'Appointment Type',
          optionsList: const <String>['In Person', 'Video Call', 'Phone Call'],
          onSelectAppointmentType: (option) {
            context.read<HomeCubit>().changeAppointmentType(option);
          },
        )
      ],
    );
  }
  @override
  bool get wantKeepAlive => true;
}