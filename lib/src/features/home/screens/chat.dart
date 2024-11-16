import 'package:doctors_appointment/src/core/helpers/base_widgets/text.dart';
import 'package:doctors_appointment/src/features/home/models/doctor_data.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:uuid/uuid.dart';
import '../../../core/constants/app_constants.dart';
import '../blocs/chat/cubit.dart';
import '../widgets/chat_widgets/bottom_bar.dart';

class Chatting extends StatelessWidget {
  final DoctorInfo info;
  const Chatting({super.key,
    required this.info
  });

  final types.User _user = const types.User(id: 'user');

  final types.User _doctor = const types.User(id: 'doctor');

  int get _creatingTime {
    return DateTime.now().millisecondsSinceEpoch - 240000;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: MyText(text: info.name),
      ),
      body: StreamBuilder<DatabaseEvent>(
          stream: context.read<ChatCubit>().getMessages(receiverId: info.id),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator());
            }else{
              return Chat(
                messages: List.generate(
                  snapshot.data!.snapshot.children.toList().length, (index) => types.TextMessage(
                  author: _user, // pinding
                  createdAt: _creatingTime,
                  id: const Uuid().v4(),
                  text: (snapshot.data!.snapshot.children.toList()[index].value as Map)['message'].toString(),
                ),).reversed.toList(),
                showUserAvatars: true,
                showUserNames: true,
                onSendPressed: (message) {},
                user: _user,
                customBottomWidget: ChatBottomBar(
                  info: info,
                ),
                theme: DefaultChatTheme(
                  inputBackgroundColor: Constants.appColor,
                  primaryColor: Constants.appColor,
                  userAvatarNameColors: [Constants.appColor],
                  messageInsetsVertical: 8,
                  messageInsetsHorizontal: 12,
                ),
              );
            }
          }
      ),
    );
  }
}