import 'package:doctors_appointment/src/core/helpers/base_extensions/context/padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helpers/base_widgets/divider.dart';
import '../../../core/helpers/base_widgets/text.dart';

class OrSignWith extends StatelessWidget {
  const OrSignWith({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: MyDivider()),
        Padding(
          padding: context.horizontalSymmetricPadding(10.w),
          child: const MyText(text: 'Or sign in with'),
        ),
        const Expanded(child: MyDivider()),
      ],
    );
  }
}
