import 'package:doctors_appointment/src/core/helpers/base_extensions/context/padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../generated/assets.dart';
import '../../../../../core/helpers/app_widgets/app_button.dart';
import '../../../../../core/helpers/base_widgets/text.dart';


class PaymentError extends StatelessWidget {
  const PaymentError({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: context.horizontalSymmetricPadding(12.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(Assets.imagesSadFace),
            MyText(text: 'Something wrong occur', fontSize: 20.sp),
            SizedBox(
              height: 16.sp,
            ),
            AppButton(
              title: 'Try again later',
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
      ),
    );
  }
}