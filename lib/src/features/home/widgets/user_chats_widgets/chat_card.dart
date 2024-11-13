import 'package:doctors_appointment/src/core/helpers/base_widgets/image_handler.dart';
import 'package:doctors_appointment/src/core/helpers/base_widgets/text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/doctor_data.dart';

class ChatCard extends StatelessWidget {
  final DoctorInfo info;
  const ChatCard({Key? key,
    required this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: NetworkImageHandler(
        url: info.photo,
      ),
      title: MyText(text: info.name),
      subtitle: MyText(text: info.description),
      trailing: FittedBox(
        child: Column(
          children: [
            MyText(text: DateFormat("d-M-yyyy").format(DateTime.now()))
          ],
        ),
      ),
    );
  }
}
