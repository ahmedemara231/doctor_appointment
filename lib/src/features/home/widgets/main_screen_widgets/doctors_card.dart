import 'package:doctors_appointment/src/core/helpers/base_extensions/context/padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/base_widgets/image_handler.dart';
import '../../../../core/helpers/base_widgets/text.dart';

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
    return Padding(
      padding: context.verticalSymmetricPadding(12.h),
      child: ListTile(
        leading: NetworkImageHandler(url: url),
        title:
        MyText(text: doctorName, fontWeight: FontWeight.bold, fontSize: 22.sp),
        subtitle:
        MyText(text: speciality, color: Colors.grey, fontSize: 14.sp),
      ),
    );
  }
}
