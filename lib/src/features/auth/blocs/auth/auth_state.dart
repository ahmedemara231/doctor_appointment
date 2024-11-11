import 'package:equatable/equatable.dart';

enum States {authInitial, loginLoading, loginSuccess, loginError, registerLoading, registerSuccess, registerError}
class AuthState extends Equatable
{
  States? currentState;
  dynamic resultMsg;

  AuthState({
    this.currentState,
    this.resultMsg,
  });

  factory AuthState.initial(){
    return AuthState(
        currentState : States.authInitial,
        resultMsg : '',
    );
  }

  AuthState copyWith({
    required States state,
    dynamic resultMsg,
  })
  {
    return AuthState(
      currentState: state,
      resultMsg: resultMsg?? this.resultMsg,
    );
  }

  @override
  List<Object?> get props => [currentState, resultMsg];
}