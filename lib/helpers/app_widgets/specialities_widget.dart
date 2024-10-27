import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../base_widgets/text.dart';

class SpecialitiesWidget extends StatelessWidget {
  const SpecialitiesWidget({Key? key,
    required this.title,
    required this.imageUrl,
  }) : super(key: key);

  final String title;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30.sp,
          backgroundColor: Colors.grey[200],
          child: Image.asset(imageUrl),
        ),
        const SizedBox(height: 5),
        MyText(
          text: title,
          fontSize: 12.sp,
        )
      ],
    );
  }
}