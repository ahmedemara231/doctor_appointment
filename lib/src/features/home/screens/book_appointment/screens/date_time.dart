import 'package:doctors_appointment/src/core/helpers/base_extensions/context/mediaQuery.dart';
import 'package:doctors_appointment/src/core/helpers/base_extensions/context/padding.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../core/helpers/app_widgets/app_button.dart';
import '../../../../../core/helpers/base_widgets/error_builder/screen.dart';
import '../../../../../core/helpers/base_widgets/text.dart';
import '../../../blocs/home/cubit.dart';
import '../../../blocs/home/state.dart';
import '../../../widgets/book_appointmentwidgets/appointment_type.dart';
import '../../../widgets/book_appointmentwidgets/date_picker.dart';
import '../interface.dart';
class DateTimeAppointment extends StatefulWidget implements CheckingValue{
  DateTimeAppointment({super.key});

  @override
  State<DateTimeAppointment> createState() => _DateTimeAppointmentState();

  @override
  var mainValue;
}

class _DateTimeAppointmentState extends State<DateTimeAppointment> with AutomaticKeepAliveClientMixin {
  final List<String> _times = ['8:00 AM','9:30 AM', '10:00 AM', '11:00 AM', '12:00 PM', '1:00 PM'];
  final List<String> options = ['In Person', 'Video Call', 'Phone Call'];


  @override
  void initState() {
    context.read<HomeCubit>().getAvailableTimes();
    super.initState();
  }

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
          child: const MyText(text: 'Available time', fontWeight: FontWeight.w500,),
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
                      widget.mainValue = _times[index];
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
          optionsList: options,
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