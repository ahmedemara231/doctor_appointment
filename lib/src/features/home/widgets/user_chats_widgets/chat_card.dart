import 'package:doctors_appointment/src/core/helpers/base_widgets/image_handler.dart';
import 'package:doctors_appointment/src/core/helpers/base_widgets/text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: CircleAvatar(
          radius: 35.sp,
          child: NetworkImageHandler(
            url: 'https://tse1.mm.bing.net/th?id=OIP.KTnWQ7-rzLG4q2_vZzMbTAHaHa&pid=Api&P=0&h=220',
          ),
        ),
        title: MyText(text: 'Doc Name'),
        subtitle: MyText(text: 'Messageeeeeeeeeeeeeeeee'),
        trailing: FittedBox(
          child: Column(
            children: [
              MyText(text: DateFormat("d-M-yyyy").format(DateTime.now()))
            ],
          ),
        ),
      ),
    );
  }
}
