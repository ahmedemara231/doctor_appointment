import 'package:doctors_appointment/constants/app_constants.dart';
import 'package:doctors_appointment/helpers/base_extensions/context/padding.dart';
import 'package:doctors_appointment/helpers/base_widgets/text.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectGender extends StatefulWidget {
  const SelectGender({Key? key,
    required this.onSelectGender,
  }) : super(key: key);
  final void Function(String selectedGender) onSelectGender;

  @override
  State<SelectGender> createState() => _SelectGenderState();
}

class _SelectGenderState extends State<SelectGender> {
  String gender = 0.toString();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.verticalSymmetricPadding(12.h),
      child: ExpansionTileCard(
        leading: CircleAvatar(
            backgroundColor: Constants.appColor.withOpacity(.4),
            child: MyText(text: 'Gender', fontSize: 10.sp,)),
        title: MyText(text: 'Select Gender'),
        children: <Widget>[
          const Divider(
            thickness: 1.0,
            height: 1.0,
          ),
          RadioListTile<String>(
            title: const Text('Male', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            value: 'Male',
            selected: gender == 0.toString()? true : false,
            groupValue: 'Text',
            activeColor: Colors.blue,
            onChanged: (value) {
              setState(() {
                gender = 0.toString();
                widget.onSelectGender(gender);
              });
            },
          ),
          RadioListTile<String>(
            title: const Text('Female', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            value: 'Female',
            selected: gender == 1.toString()? true : false,
            groupValue: 'Text',
            activeColor: Colors.blue,
            onChanged: (value) {
              setState(() {
                gender = 1.toString();
                widget.onSelectGender(gender);
              });
            },
          ),
        ],
      ),
    );
  }
}