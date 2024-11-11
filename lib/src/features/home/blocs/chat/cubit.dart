import 'package:doctors_appointment/src/features/home/blocs/chat/state.dart';
import 'package:doctors_appointment/src/features/home/repositories/get.dart';
import 'package:doctors_appointment/src/features/home/repositories/post.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChattingState> {
  ChatCubit({
    required this.homePostRepo,
    required this.homeGetRepo,
}) : super(ChattingState.initial());

  late final HomePostRepo homePostRepo;
  late final HomeGetRepo homeGetRepo;

  Future<void> sendMessage({
    required String message,
    required int receiverId
  })async{
    final result = await homePostRepo.sendMessageToDoctor(
        message: message,
        receiverId: receiverId
    );

    if(result.isSuccess()){
      emit(state.copyWith(state: ChatStates.sendMessageSuccess));
    }else{
      emit(state.copyWith(state: ChatStates.sendMessageError));
    }
  }

  Stream<DatabaseEvent> getMessages({required int receiverId}){
    return homeGetRepo.getMessages(receiverId);
  }

  void pickFile(){}
  void saveFile(){}
  void pickImage(){}
  void saveImage(){}

}
