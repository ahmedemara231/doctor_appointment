import 'package:doctors_appointment/src/features/home/widgets/doctor_details_widgets/rating/widgets/give_rate_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rating_summary/rating_summary.dart';

import '../../../../../core/helpers/app_widgets/app_button.dart';
import '../../../models/doctor_data.dart';

class Rating extends StatelessWidget {
  final DoctorInfo info;
  Rating({super.key,
    required this.scaffoldKey,
    required this.info
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
                  (context) => GiveRateSheet(
                    info: info,
                  )
          );
          },
        ),
      ],
    );
  }
}
