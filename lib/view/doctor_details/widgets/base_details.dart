import 'package:doctors_appointment/helpers/base_widgets/image_handler.dart';
import 'package:doctors_appointment/helpers/base_widgets/text.dart';
import 'package:doctors_appointment/model/remote/firebase/realtime_database/services/patients_service/data_source.dart';
import 'package:doctors_appointment/model/remote/firebase/realtime_database/services/patients_service/data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../view_model/home/chats.dart';

class BaseDetails extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String specialization;

  const BaseDetails({Key? key,
    required this.imageUrl,
    required this.name,
    required this.specialization,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: NetworkImageHandler(url: imageUrl),
      title: MyText(text: name, fontWeight: FontWeight.w500, fontSize: 16.sp),
      subtitle: MyText(text: specialization),
      trailing: IconButton(
        onPressed: ()async {
          PatientsDataSource chatsTest = PatientsDataSource();
          chatsTest.initDatabase();

          await chatsTest.sendMessage();
          chatsTest.getMessage();
        },
        icon: const Icon(Icons.chat_outlined),
      ),
    );
  }
}
