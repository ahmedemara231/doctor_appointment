import 'package:doctors_appointment/src/core/helpers/base_extensions/context/routes.dart';
import 'package:doctors_appointment/src/features/home/screens/chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../core/helpers/base_widgets/image_handler.dart';
import '../../../../core/helpers/base_widgets/text.dart';
import '../../models/doctor_data.dart';

class BaseDetails extends StatelessWidget {
  final DoctorInfo info;
  const BaseDetails({Key? key,
    required this.info
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: NetworkImageHandler(url: info.photo),
      title: MyText(text: info.name, fontWeight: FontWeight.w500, fontSize: 16.sp),
      subtitle: MyText(text: info.specialization.name),
      trailing: IconButton(
        onPressed: () => context.normalNewRoute(
            Chatting(info: info),
            type: PageTransitionType.rightToLeft
        ),
        icon: const Icon(Icons.chat_outlined),
      ),
    );
  }
}
