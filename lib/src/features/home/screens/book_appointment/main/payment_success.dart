import 'package:doctors_appointment/generated/assets.dart';
import 'package:doctors_appointment/src/core/helpers/base_extensions/context/mediaQuery.dart';
import 'package:doctors_appointment/src/core/helpers/base_extensions/context/padding.dart';
import 'package:doctors_appointment/src/features/home/screens/book_appointment/screens/summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:svg_flutter/svg.dart';

import '../../../../../core/helpers/app_widgets/app_button.dart';
import '../../../../../core/helpers/base_widgets/text.dart';

class PaymentSuccess extends StatelessWidget {
  const PaymentSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: context.horizontalSymmetricPadding(12.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(Assets.imagesSuccessfulPay),
            Padding(
              padding: context.verticalSymmetricPadding(25.h),
              child: MyText(text: 'Booking Confirmed', fontSize: 20.sp),
            ),
            SizedBox(
                height: context.setHeight(3),
                child: Summary()
            ),

            AppButton(
              title: 'Done',
              onPressed: () => Navigator.pop(context, 'return_from_screen_3'),
            )
          ],
        ),
      ),
    );
  }
}