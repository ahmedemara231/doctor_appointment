import 'package:equatable/equatable.dart';

enum ChatStates {
  initial,
  sendMessageLoading,
  sendMessageSuccess,
  sendMessageError,
}
class ChattingState extends Equatable {
  ChatStates? currentState;
  String? msg;
  String? errorMsg;
  ChattingState({
    this.currentState,
    this.msg,
    this.errorMsg,
  });

  factory ChattingState.initial(){
    return ChattingState(
      currentState: ChatStates.initial,
      msg: '',
      errorMsg: '',
    );
  }

  ChattingState copyWith({
    required ChatStates state,
    String? msg,
    String? errorMsg,
  }){
    return ChattingState(
      currentState: state,
      msg: msg?? this.msg,
      errorMsg: errorMsg?? this.errorMsg,
    );
  }

  @override
  List<Object?> get props => [
    currentState,
    msg,
    errorMsg,
  ];
}
