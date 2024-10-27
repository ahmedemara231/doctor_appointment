import 'package:doctors_appointment/helpers/base_widgets/text.dart';
import 'package:doctors_appointment/helpers/data_types/about_doctor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutWidget extends StatelessWidget {
  AboutWidget({super.key,
    required this.values
  });

  final List<AboutDoctor> values;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) => AboutElement(
            title: values[index].title,
            value: values[index].value
        ),
        separatorBuilder: (context, index) => SizedBox(height: 25.h,),
        itemCount: values.length
    );
  }
}

class AboutElement extends StatelessWidget {
  const AboutElement({super.key,
    required this.title,
    required this.value
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(text: title, fontSize: 18.sp, fontWeight: FontWeight.w500,),
        const SizedBox(height: 5.0),
        MyText(text: value, color: Colors.grey,)
      ],
    );
  }
}