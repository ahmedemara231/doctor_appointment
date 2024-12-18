import 'package:doctors_appointment/src/core/helpers/base_extensions/context/padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/helpers/base_widgets/text.dart';

class SortByWidget extends StatefulWidget {
  const SortByWidget({super.key,
    required this.sortingType,
    required this.sortingValues,
    required this.onSort,
});

final void Function(String selectedOption) onSort;
final String sortingType;
  final List<String> sortingValues;

  @override
  State<SortByWidget> createState() => _SortByWidgetState();
}

class _SortByWidgetState extends State<SortByWidget> {

  late int selected;

  @override
  void initState() {
    selected = 0;
    widget.onSort(widget.sortingValues[0]);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(text: widget.sortingType, fontSize: 16.sp,),
        SizedBox(height: 12.sp,),
        SizedBox(
          height: 50.h,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(widget.sortingValues.length, (index) => InkWell(
              onTap: () {
                setState(() => selected = index);
                widget.onSort(widget.sortingValues[index]);
              },
              child: Padding(
                padding: context.horizontalSymmetricPadding(5.w),
                child: Container(
                  width: 100.w,
                  decoration: BoxDecoration(
                    color: selected == index? Constants.appColor : Colors.grey.withOpacity(.1),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                        child: FittedBox(
                            child: Row(
                              children: [
                                if(widget.sortingType == 'Rating')
                                  Icon(
                                    Icons.star,
                                    color: selected == index?
                                    Colors.white : Colors.grey.withOpacity(.7),
                                  ),
                                MyText(
                                  text: widget.sortingValues[index],
                                  color: selected == index?
                                  Colors.white : Colors.grey.withOpacity(.7),
                                ),
                              ],
                            )
                        )
                    ),
                  ),
                ),
              ),
            ),),
          ),
        )
      ],
    );
  }
}