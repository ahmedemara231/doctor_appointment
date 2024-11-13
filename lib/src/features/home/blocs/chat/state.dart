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
}
class ChattingState extends Equatable {
  ChatStates? currentState;
  String? msg;
  String? errorMsg;
  List<DoctorInfo>? chatDoctors;
  ChattingState({
    this.currentState,
    this.msg,
    this.errorMsg,
    this.chatDoctors,
  });

  factory ChattingState.initial(){
    return ChattingState(
      currentState: ChatStates.initial,
      msg: '',
      errorMsg: '',
      chatDoctors: const [],
    );
  }

  ChattingState copyWith({
    required ChatStates state,
    String? msg,
    String? errorMsg,
    List<DoctorInfo>? chatDoctors,
  }){
    return ChattingState(
      currentState: state,
      msg: msg?? this.msg,
      errorMsg: errorMsg?? this.errorMsg,
      chatDoctors: chatDoctors?? this.chatDoctors,
    );
  }

  @override
  List<Object?> get props => [
    currentState,
    msg,
    errorMsg,
    chatDoctors,
  ];
}
