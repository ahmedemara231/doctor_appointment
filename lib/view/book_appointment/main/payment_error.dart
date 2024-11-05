import 'package:doctors_appointment/generated/assets.dart';
import 'package:doctors_appointment/helpers/app_widgets/app_button.dart';
import 'package:doctors_appointment/helpers/base_extensions/context/mediaQuery.dart';
import 'package:doctors_appointment/helpers/base_extensions/context/padding.dart';
import 'package:doctors_appointment/helpers/base_widgets/text.dart';
import 'package:doctors_appointment/view/book_appointment/screens/summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:svg_flutter/svg.dart';

  class PaymentError extends StatelessWidget {
  const PaymentError({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Padding(
      //   padding: context.horizontalSymmetricPadding(12.w),
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       SvgPicture.asset(Assets.imagesSadFace),
      //       MyText(text: 'Booking Confirmed', fontSize: 20.sp),
      //       SizedBox(
      //         height: 16.sp,
      //       ),
      //       SizedBox(
      //           height: context.setHeight(3),
      //           child: Summary()
      //       ),
      //
      //       AppButton(
      //         title: 'Done',
      //         onPressed: () => Navigator.pop(context, 'fromSuccess'),
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}