import 'dart:async';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:doctors_appointment/src/core/helpers/base_extensions/context/mediaQuery.dart';
import 'package:doctors_appointment/src/core/helpers/base_extensions/context/padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_icon_button/loading_icon_button.dart';
import '../../../../../../core/constants/app_constants.dart';
import '../../../../../../core/helpers/app_widgets/app_loading_button.dart';
import '../../../../../../core/helpers/base_widgets/text.dart';
import '../../../../blocs/home/cubit.dart';
import '../../../../blocs/home/state.dart';
import '../../../../models/doctor_data.dart';
class GiveRateSheet extends StatefulWidget {
  final DoctorInfo info;
  const GiveRateSheet({super.key,
    required this.info,
  });

  @override
  State<GiveRateSheet> createState() => _GiveRateSheetState();
}

class _GiveRateSheetState extends State<GiveRateSheet> {

  late LoadingButtonController controller;

  @override
  void initState() {
    controller = LoadingButtonController();
    super.initState();
  }

  @override
  void dispose() {
    controller.stop();
    super.dispose();
  }

  double rating = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.setHeight(2),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          border: Border.all(color: Constants.appColor)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyText(text: 'Give a rate', fontSize: 20.sp,),
          Center(
            child: Padding(
              padding: context.verticalSymmetricPadding(16.h),
              child: RatingBar(
                alignment: Alignment.center,
                size: 40.sp,
                filledIcon: Icons.star,
                emptyIcon: Icons.star_border,
                onRatingChanged: (value) => rating = value,
                initialRating: 1,
                maxRating: 5,
              ),
            ),
          ),
          SizedBox(
              width: context.setWidth(1.3),
              child: BlocListener<HomeCubit, HomeState>(
                listener: (context, state) {
                  switch(state.currentState){
                    case States.giveRateLoading:
                      controller.start();

                    case States.giveRateSuccess:
                      controller.success();

                    default:
                      controller.stop();
                      break;
                  }
                  Timer(
                      const Duration(seconds: 1),
                          () {
                    Navigator.pop(context);
                  });
                },
                child: AppLoadingButton(
                    onPressed: () {
                      context.read<HomeCubit>().giveRate(
                          rating: rating,
                          doctorId: widget.info.id
                      );
                    },
                    title: 'Submit',
                    btnController: controller
                ),
              )
          )
        ],
      ),
    );
  }
}
