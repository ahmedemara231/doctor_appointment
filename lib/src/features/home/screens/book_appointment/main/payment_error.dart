import 'package:flutter/material.dart';


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