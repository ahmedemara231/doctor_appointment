import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../base_widgets/text.dart';

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
        child: MyText(
          text: 'No Doctors refers to this name',
          fontWeight: FontWeight.w500,
          fontSize: 16.sp,
        )
    );
  }
}
