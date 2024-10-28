import 'package:doctors_appointment/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyDatePicker extends StatelessWidget {
  MyDatePicker({Key? key,
    required this.onSelect,
  }) : super(key: key);

  DateTime _selectedValue = DateTime.now();
  void Function(DateTime)? onSelect;
  @override
  Widget build(BuildContext context) {
    return DatePicker(
      DateTime.now(),
      daysCount: 14,
      deactivatedColor: Colors.grey.withOpacity(.3),
      dateTextStyle: TextStyle(fontSize: 14.sp),
      initialSelectedDate: DateTime.now(),
      dayTextStyle: TextStyle(fontSize: 11.sp),
      monthTextStyle: TextStyle(fontSize: 11.sp),
      selectionColor: Constants.appColor,
      selectedTextColor: Colors.white,
      height: 90.h,
      onDateChange: (date) {
          _selectedValue = date;
          onSelect?.call(date);
      },
    );
  }
}
