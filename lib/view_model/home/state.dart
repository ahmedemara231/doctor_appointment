import 'package:equatable/equatable.dart';

enum States {homeInitial, homeDataLoading, homeDataSuccess, homeDataError}
class HomeState extends Equatable
{
  States? currentState;
  dynamic homeData;
  String? errorMsg;

  HomeState({
    this.currentState,
    this.homeData,
    this.errorMsg
  });

  factory HomeState.initial(){
    return HomeState(
        currentState : States.homeInitial,
        homeData : const [],
        errorMsg : ''
    );
  }

  HomeState copyWith({
    required States state,
    dynamic homeData, String? errorMessage
  })
  {
    return HomeState(
      currentState: state,
      homeData: homeData?? this.homeData,
      errorMsg: errorMessage?? errorMsg,
    );
  }

  @override
  List<Object?> get props => [currentState, homeData, errorMsg];
}