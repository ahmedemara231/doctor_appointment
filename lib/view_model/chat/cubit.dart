import 'package:doctors_appointment/view_model/chat/state.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/remote/firebase/realtime_database/services/interface.dart';

class ChatCubit extends Cubit<ChattingState> {
  ChatCubit(this.user) : super(ChattingState.initial());

  late ChatWith user;
  Future<void> sendMessage({
    required String message,
    required int receiverId
  })async{
    final result = await user.sendMessage(message: message, receiverId: receiverId);

    if(result.isSuccess()){
      emit(state.copyWith(state: ChatStates.sendMessageSuccess));
    }else{
      emit(state.copyWith(state: ChatStates.sendMessageError));
    }
  }

  Stream<DatabaseEvent> getMessages({required int receiverId}){
    return user.getMessages(receiverId);
  }

  void pickFile(){}
  void saveFile(){}
  void pickImage(){}
  void saveImage(){}


}
