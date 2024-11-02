import 'package:doctors_appointment/generated/assets.dart';
import 'package:doctors_appointment/helpers/base_extensions/context/mediaQuery.dart';
import 'package:doctors_appointment/helpers/base_widgets/text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 15.h),
          child: Container(
            width: double.infinity,
            height: context.setHeight(3.2),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width : context.setWidth(2),
                  child: Text(
                    'Book and schedule with nearest doctor'.tr(),
                    style: TextStyle(
                      fontSize: 22.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: MyText(
                    text: 'Find Nearby'.tr(),
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: context.locale.languageCode == 'en'?
          Alignment.topRight : Alignment.topLeft,
          child: Image.asset(
            Assets.imagesHomeDoctorImage,
            height: context.setHeight(3),
            fit: BoxFit.fill,
          ),
        ),
      ],
    );
  }
}