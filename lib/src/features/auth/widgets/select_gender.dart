import 'package:doctors_appointment/src/core/helpers/base_extensions/context/padding.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/helpers/base_widgets/text.dart';

class SelectGender extends StatefulWidget {
  const SelectGender({Key? key,
    required this.onSelectGender,
  }) : super(key: key);
  final void Function(String selectedGender) onSelectGender;

  @override
  State<SelectGender> createState() => _SelectGenderState();
}

class _SelectGenderState extends State<SelectGender> {
  String genderCode = 0.toString();
  String genderName = 'Male';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.verticalSymmetricPadding(12.h),
      child: ExpansionTileCard(
        leading: CircleAvatar(
            backgroundColor: Constants.appColor.withOpacity(.4),
            child: MyText(text: 'Gender', fontSize: 10.sp,)),
        title: const MyText(text: 'Select Gender'),
        children: <Widget>[
          Padding(
            padding: context.horizontalSymmetricPadding(7.w),
            child: const Divider(
              thickness: 1.0,
              height: 1.0,
            ),
          ),
          RadioListTile<String>(
            title: const Text('Male', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            value: 'Male',
            selected: genderCode == 0.toString()? true : false,
            groupValue: genderName,
            onChanged: (value) {
              setState(() {
                genderCode = 0.toString();
                genderName = 'Male';
                widget.onSelectGender(genderCode);
              });
            },
          ),
          RadioListTile<String>(
            title: const Text('Female', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            value: 'Female',
            selected: genderCode == 1.toString()? true : false,
            dense: true,
            groupValue: genderName,
            onChanged: (value) {
              setState(() {
                genderCode = 1.toString();
                genderName = 'Female';
                widget.onSelectGender(genderCode);
              });
            },
          ),
        ],
      ),
    );
  }
}