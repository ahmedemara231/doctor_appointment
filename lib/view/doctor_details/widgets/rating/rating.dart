import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:doctors_appointment/constants/app_constants.dart';
import 'package:doctors_appointment/helpers/app_widgets/app_button.dart';
import 'package:doctors_appointment/helpers/app_widgets/app_loading_button.dart';
import 'package:doctors_appointment/helpers/base_extensions/context/mediaQuery.dart';
import 'package:doctors_appointment/helpers/base_extensions/context/padding.dart';
import 'package:doctors_appointment/helpers/base_widgets/divider.dart';
import 'package:doctors_appointment/helpers/base_widgets/text.dart';
import 'package:doctors_appointment/view/doctor_details/widgets/rating/widgets/give_rate_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_icon_button/loading_icon_button.dart';
import 'package:rating_summary/rating_summary.dart';

class Rating extends StatelessWidget {
  Rating({super.key,
    required this.scaffoldKey
  });

  late GlobalKey<ScaffoldState> scaffoldKey;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const RatingSummary(
          counter: 13,
          average: 4,
          showAverage: true,
          counterFiveStars: 5,
          counterFourStars: 4,
          counterThreeStars: 2,
          counterTwoStars: 1,
          counterOneStars: 1,
        ),
        SizedBox(height: 16.h),
        AppButton(
          title: 'Rate',
          color: Colors.grey[350],
          onPressed: () {
          scaffoldKey.currentState!.showBottomSheet(
                  (context) => const GiveRateSheet()
          );
          },
        ),
      ],
    );
  }
}
