import 'package:doctors_appointment/helpers/base_extensions/context/padding.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/app_constants.dart';
import '../../../helpers/base_widgets/text.dart';

class ChooseFromAvailableOptions extends StatefulWidget {
  const ChooseFromAvailableOptions({Key? key,
    required this.onSelectAppointmentType,
    required this.title,
    required this.optionsList,
  }) : super(key: key);

  final String title;
  final List<String> optionsList;
  @override
  State<ChooseFromAvailableOptions> createState() => _ChooseFromAvailableOptionsState();

  final void Function(String option) onSelectAppointmentType;
}

class _ChooseFromAvailableOptionsState extends State<ChooseFromAvailableOptions> {
  String option = '';
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: context.verticalSymmetricPadding(12.h),
      child: ExpansionTileCard(
        title: MyText(text: widget.title),
        children: List.generate(
          widget.optionsList.length,
              (index) => RadioListTile<String>(
          activeColor: Constants.appColor,
          title: MyText(
              text: widget.optionsList[index],
              fontSize: 16.sp,
          ),
          value: widget.optionsList[index],
          selected: option == widget.optionsList[index]? true : false,
          groupValue: option,
          onChanged: (value) {
            setState(() {
              option = value!;
              widget.onSelectAppointmentType(option);
            });
          },
        ),
        )
      ),
    );
  }
}