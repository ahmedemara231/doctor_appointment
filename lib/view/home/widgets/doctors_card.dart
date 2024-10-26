import 'package:doctors_appointment/helpers/base_extensions/context/mediaQuery.dart';
import 'package:doctors_appointment/helpers/base_extensions/context/routes.dart';
import 'package:doctors_appointment/helpers/base_widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../helpers/base_widgets/image_handler.dart';

class DoctorsCard extends StatelessWidget {
  const DoctorsCard({Key? key,
    required this.url,
    required this.doctorName,
    required this.speciality,
  }) : super(key: key);

  final String url;
  final String doctorName;
  final String speciality;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: context.setWidth(4),
              height: context.setWidth(3.5),
              child: NetworkImageHandler(url: url)),
          Column(
            children: [
              MyText(text: doctorName, fontWeight: FontWeight.bold, fontSize: 22.sp),
              MyText(text: speciality, color: Colors.grey, fontSize: 14.sp),
        ],
      ),
        ]
      )
    );
  }
}
