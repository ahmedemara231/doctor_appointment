import 'package:doctors_appointment/generated/assets.dart';
import 'package:doctors_appointment/helpers/base_widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LocationWidget extends StatelessWidget {
  final String city;
  const LocationWidget({super.key,
    required this.city,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText(text: 'Practice Place', fontSize: 18.sp, fontWeight: FontWeight.w500,),
          MyText(text: city, color: Colors.grey,),
          SizedBox(height: 16.sp),
          MyText(text: 'Location', fontWeight: FontWeight.w500, fontSize: 16.sp,),
          Image.asset(Assets.imagesMap)
        ],
      ),
    );
  }
}