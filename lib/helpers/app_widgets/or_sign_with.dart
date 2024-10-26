import 'package:doctors_appointment/helpers/base_extensions/context/padding.dart';
import 'package:doctors_appointment/helpers/base_widgets/divider.dart';
import 'package:doctors_appointment/helpers/base_widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrSignWith extends StatelessWidget {
  const OrSignWith({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: MyDivider()),
        Padding(
          padding: context.horizontalSymmetricPadding(10.w),
          child: MyText(text: 'Or sign in with'),
        ),
        const Expanded(child: MyDivider()),
      ],
    );
  }
}
