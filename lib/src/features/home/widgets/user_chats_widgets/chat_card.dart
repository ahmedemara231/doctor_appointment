import 'package:doctors_appointment/src/core/helpers/base_widgets/image_handler.dart';
import 'package:doctors_appointment/src/core/helpers/base_widgets/text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../blocs/chat/cubit.dart';
import '../../models/doctor_data.dart';

class ChatCard extends StatelessWidget {
  final DoctorInfo info;

  const ChatCard({Key? key,
    required this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DatabaseEvent>(
        stream: context.read<ChatCubit>().getMessages(receiverId: info.id),
      builder: (context, snapshot) {
        return snapshot.connectionState == ConnectionState.waiting?
        const Center(child: CircularProgressIndicator()) :
        ListTile(
          leading: NetworkImageHandler(
            url: info.photo,
          ),
          title: MyText(text: info.name, fontSize: 16.sp, fontWeight: FontWeight.w500,),
          subtitle: MyText(text: (snapshot.data!.snapshot.children.last.value as Map)['message'].toString()),
          trailing: FittedBox(
            child: Column(
              children: [
                MyText(text: ((snapshot.data!.snapshot.children.last.value as Map)['date'] as String).split("/").first),
                MyText(text: ((snapshot.data!.snapshot.children.last.value as Map)['date'] as String).split("/").last),
                // number of messages that didn't see
              ],
            ),
          ),
        );
      }
    );
  }
}
