import 'package:doctors_appointment/src/core/helpers/base_extensions/context/mediaQuery.dart';
import 'package:doctors_appointment/src/core/helpers/base_extensions/context/padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_icon_button/loading_icon_button.dart';

import '../../blocs/home/cubit.dart';
import 'sort_by.dart';
import '../../../../core/helpers/base_widgets/text.dart';
import '../../../../core/helpers/data_types/sorting_result.dart';
import '../../../../core/helpers/app_widgets/app_loading_button.dart';

class Sorting extends StatefulWidget {
  final bool isRecommended;
  const Sorting({super.key,
    required this.isRecommended
  });

  @override
  State<Sorting> createState() => _SortingState();
}

class _SortingState extends State<Sorting> {

  late LoadingButtonController btnController;
  SortingResult result = SortingResult();

  List<String> values = const <String>[
    'All',
    'General',
    'Cardiology',
    'Dermatology',
    'Gastroenterology',
    'Orthopedics',
    'Urology',
    'Neurology',
  ];

  List<String> ratingValues = const <String>['1', '2', '3', '4', '5', 'All'];

  @override
  void initState() {
    btnController = LoadingButtonController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.horizontalSymmetricPadding(12.w),
      child: Container(
        width: double.infinity,
        height: context.setHeight(1.5),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            SizedBox(height: 16.h),
            MyText(text: 'Sort By', fontSize:  20.sp, fontWeight: FontWeight.w500,),
            Padding(
              padding: context.verticalSymmetricPadding(16.h),
              child: const Divider(),
            ),
            SortByWidget(sortingType: 'Specialization', sortingValues: values, onSort: (selectedOption) {
              result.speciality = selectedOption;
            },),
            Padding(
              padding: context.verticalSymmetricPadding(22.h),
              child: SortByWidget(
                sortingType: 'Rating',
                sortingValues: ratingValues,
                onSort: (selectedOption) {
                result.rating = selectedOption;
              },),
            ),
            AppLoadingButton(
                onPressed: () {
                  context.read<HomeCubit>().sortDoctors(
                      result: result,
                      isRecommended: widget.isRecommended
                  );
                  btnController.success();
                  Navigator.pop(context);
                },
                title: 'Sort', btnController: btnController
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    btnController.stop();
    super.dispose();
  }
}
