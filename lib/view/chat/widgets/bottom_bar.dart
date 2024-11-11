import 'package:doctors_appointment/constants/app_constants.dart';
import 'package:doctors_appointment/helpers/base_widgets/text_field.dart';
import 'package:doctors_appointment/helpers/helper_methods/file_picker.dart';
import 'package:doctors_appointment/view_model/chat/state.dart';
import 'package:doctors_appointment/view_model/home/cubit.dart';
import 'package:doctors_appointment/view_model/home/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../view_model/chat/cubit.dart';

class ChatBottomBar extends StatefulWidget {
  const ChatBottomBar({super.key});
  @override
  State<ChatBottomBar> createState() => _ChatBottomBarState();
}

class _ChatBottomBarState extends State<ChatBottomBar> {
  final TextEditingController typingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: TFF(
              autoValidateMode: AutovalidateMode.disabled,
                obscureText: false,
                controller: typingController,
                onChanged: (p0) => setState(() {}),
                prefixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.emoji_emotions_outlined, color: Colors.grey,)
                ),
                hintText: 'Type a message ...',
                hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16.sp
                ),
                suffixIcon: FittedBox(
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () async => await MyFilePicker.pick(),
                          icon: const Icon(Icons.attachment, color: Colors.grey,)
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.camera_alt_outlined, color: Colors.grey,)
                      ),
                    ],
                  ),
                )
            ),
          ),
          if(typingController.text.isNotEmpty)
            BlocBuilder<HomeCubit, HomeState>(
              buildWhen: (previous, current) => current.currentState == States.homeInitial,
              builder: (context, state) => BlocConsumer<ChatCubit, ChattingState>(
                listener: (context, chatState) {
                  if(chatState.currentState == ChatStates.sendMessageSuccess){
                    typingController.clear();
                  }
                },
                builder: (context, chatState) => IconButton(
                    onPressed: () async=> context.read<ChatCubit>().sendMessage(
                        message: typingController.text,
                        receiverId: state.selectedDoctor!.id
                    ),
                    icon: Icon(Icons.send, color: Constants.appColor,)
                ),
              ),
            )
        ],
      )
    );
  }
}
