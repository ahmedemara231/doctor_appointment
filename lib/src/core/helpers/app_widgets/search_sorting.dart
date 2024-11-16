import 'package:doctors_appointment/src/core/helpers/app_widgets/app_loading_button.dart';
import 'package:doctors_appointment/src/core/helpers/base_extensions/context/mediaQuery.dart';
import 'package:doctors_appointment/src/core/helpers/base_extensions/context/padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_icon_button/loading_icon_button.dart';
import '../../../features/home/widgets/recommended_doctors_widgets/sort_by.dart';
import '../base_widgets/divider.dart';
import '../base_widgets/text.dart';
import 'doctors_search.dart';

class SearchAndSorting extends StatefulWidget {
  const SearchAndSorting({super.key,
    // config
    required this.value,
    required this.scaffoldKey,
    required this.controller,

    // search
    required this.onChanged,

    // sorting
    // required this.sortByWidgets,
    // required this.onSortBtnPress,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;
  final TextEditingController controller;
  final bool value;
  final void Function(String)? onChanged;
  // final void Function()? onSortBtnPress;
  // List<SortByWidget> sortByWidgets;

  @override
  State<SearchAndSorting> createState() => _SearchAndSortingState();
}

class _SearchAndSortingState extends State<SearchAndSorting> {

  late final LoadingButtonController btnController;

  @override
  void initState() {
    btnController = LoadingButtonController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: widget.value ? 90.h : 0,
              child: widget.value ?
              DoctorsSearch(
                controller: widget.controller,
                onChanged: widget.onChanged
              ) : const SizedBox.shrink()
          ),
        ),
        Padding(
          padding: context.horizontalSymmetricPadding(7.w),
          child: IconButton(
              onPressed: () {
                widget.scaffoldKey.currentState?.showBottomSheet((context) => SizedBox(
                  height: context.setHeight(2),
                  child: Padding(
                    padding: context.horizontalSymmetricPadding(12.w),
                    child: Column(
                      children: [
                        SizedBox(height: 16.h),
                        MyText(text: 'Sort By', fontSize:  20.sp, fontWeight: FontWeight.w500,),
                        Padding(
                          padding: context.verticalSymmetricPadding(16.h),
                          child: const MyDivider(),
                        ),
                        // Column(
                        //   children: [
                        //     for(SortByWidget type in widget.sortByWidgets)
                        //       Expanded(child: type),
                        //     AppLoadingButton(
                        //         onPressed: widget.onSortBtnPress,
                        //         title: 'Sort', btnController: btnController
                        //     )
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ));
              },
              icon: const Icon(Icons.sort)
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    btnController.stop();
    widget.controller.dispose();
    widget.scaffoldKey.currentState?.dispose();
    super.dispose();
  }
}