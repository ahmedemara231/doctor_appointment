import 'package:doctors_appointment/src/core/helpers/helper_methods/image_picker.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:image_picker/image_picker.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/helpers/base_widgets/text_field.dart';
import '../../../../core/helpers/helper_methods/file_picker.dart';
import '../../blocs/chat/cubit.dart';
import '../../blocs/chat/state.dart';
import '../../blocs/home/cubit.dart';
import '../../blocs/home/state.dart';

class ChatBottomBar extends StatefulWidget {
  const ChatBottomBar({super.key});
  @override
  State<ChatBottomBar> createState() => _ChatBottomBarState();
}

class _ChatBottomBarState extends State<ChatBottomBar> {
  final TextEditingController typingController = TextEditingController();
  final _scrollController = ScrollController();
  bool emojiShowing = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TFF(
                  autoValidateMode: AutovalidateMode.disabled,
                    obscureText: false,
                    controller: typingController,
                    onChanged: (p0) => setState(() {}),
                    prefixIcon: Material(
                      color: Colors.transparent,
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              emojiShowing = !emojiShowing;
                            });
                          },
                          icon: const Icon(Icons.emoji_emotions_outlined, color: Colors.grey,)
                      ),
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
                              onPressed: () {
                                ImageSelector.selectImage(ImageSource.gallery);
                              },
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
                ),
            ],
          ),
          Offstage(
            offstage: !emojiShowing,
            child: EmojiPicker(
              onEmojiSelected: (category, emoji) => setState(() {}),
              textEditingController: typingController,
              scrollController: _scrollController,
              config: Config(
                height: 256,
                checkPlatformCompatibility: true,
                emojiViewConfig: EmojiViewConfig(
                  // Issue: https://github.com/flutter/flutter/issues/28894
                  emojiSizeMax: 28 *
                      (foundation.defaultTargetPlatform == TargetPlatform.iOS ? 1.2 : 1.0),
                ),
                skinToneConfig: const SkinToneConfig(),
                categoryViewConfig: const CategoryViewConfig(),
                bottomActionBarConfig: const BottomActionBarConfig(),
                searchViewConfig: const SearchViewConfig(),
              ),
            ),
          ),
        ],
      )
    );
  }
}