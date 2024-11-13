import 'dart:io';

import 'package:doctors_appointment/src/features/home/models/doctor_data.dart';
import 'package:equatable/equatable.dart';

enum ChatStates {
  initial,
  sendMessageLoading,
  sendMessageSuccess,
  sendMessageError,
  getChatDoctorsLoading,
  getChatDoctorsSuccess,
  getChatDoctorsError,
  selectFile,
}
class ChattingState extends Equatable {
  ChatStates? currentState;
  String? msg;
  String? errorMsg;
  List<DoctorInfo>? chatDoctors;
  File? selectedFile;
  ChattingState({
    this.currentState,
    this.msg,
    this.errorMsg,
    this.chatDoctors,
    this.selectedFile
  });

  factory ChattingState.initial(){
    return ChattingState(
      currentState: ChatStates.initial,
      msg: '',
      errorMsg: '',
      chatDoctors: const [],
      selectedFile: null,
    );
  }

  ChattingState copyWith({
    required ChatStates state,
    String? msg,
    String? errorMsg,
    List<DoctorInfo>? chatDoctors,
    File? selectedFile,
  }){
    return ChattingState(
      currentState: state,
      msg: msg?? this.msg,
      errorMsg: errorMsg?? this.errorMsg,
      chatDoctors: chatDoctors?? this.chatDoctors,
      selectedFile: selectedFile?? this.selectedFile,
    );
  }

  @override
  List<Object?> get props => [
    currentState,
    selectedFile,
    msg,
    errorMsg,
    chatDoctors,
  ];
}
