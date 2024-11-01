import 'package:doctors_appointment/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../helpers/base_widgets/text.dart';

class MyDatePicker extends StatefulWidget {
  MyDatePicker({Key? key,
    required this.onSelect,
  }) : super(key: key);

  void Function(DateTime)? onSelect;

  @override
  State<MyDatePicker> createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<MyDatePicker> {
  DateTime _selectedValue = DateTime.now();

  final cont = DatePickerController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            MyText(text: 'Select Date', fontWeight: FontWeight.w500,),
            const Spacer(),
            TextButton(
                onPressed: () {
                  showDatePicker(
                    context: context,
                    firstDate:DateTime.now(),
                    lastDate:DateTime.now().add(const Duration(days: 14)),
                  ).then((value) {
                    _selectedValue = value!;
                    widget.onSelect?.call(value);
                  });
                },
                child: MyText(text: 'Set Manual', color: Constants.appColor,)
            )
          ],
        ),
        DatePicker(
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
          controller: cont,
          onDateChange: (date) {
              _selectedValue = date;
              widget.onSelect?.call(date);
          },
        ),
      ],
    );
  }
}
