import 'package:doctors_appointment/constants/app_constants.dart';
import 'package:doctors_appointment/helpers/base_widgets/text.dart';
import 'package:doctors_appointment/view/chat/widgets/bottom_bar.dart';
import 'package:doctors_appointment/view_model/chat/cubit.dart';
import 'package:doctors_appointment/view_model/chat/state.dart';
import 'package:doctors_appointment/view_model/home/cubit.dart';
import 'package:doctors_appointment/view_model/home/state.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:uuid/uuid.dart';

import '../../model/remote/firebase/realtime_database/services/patients_service/data_source.dart';

class Chatting extends StatefulWidget {
  const Chatting({super.key});

  @override
  State<Chatting> createState() => _ChattingState();
}

class _ChattingState extends State<Chatting> {
  final types.User _user = const types.User(id: 'user');
  final types.User _doctor = const types.User(id: 'doctor');

  int get _creatingTime {
    return DateTime.now().millisecondsSinceEpoch - 240000;
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: MyText(text: state.selectedDoctor!.name)
        ),
        body: StreamBuilder<DatabaseEvent>(
            stream: context.read<ChatCubit>().getMessages(receiverId: state.selectedDoctor!.id),
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
                  customBottomWidget: const ChatBottomBar(),
                  audioMessageBuilder: (p0, {messageWidth = 100}) => const Icon(Icons.add),
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
      ),
    );
  }
}