import 'package:equatable/equatable.dart';

import '../../helpers/data_types/doctor_data.dart';

enum States {homeInitial, homeDataLoading, homeDataSuccess, homeDataError}
class HomeState extends Equatable
{
  States? currentState;
  List<dynamic>? homeData;
  List<dynamic>? recommendedDoctors;
  String? errorMsg;

  HomeState({
    this.currentState,
    this.homeData,
    this.recommendedDoctors,
    this.errorMsg
  });

  factory HomeState.initial(){
    return HomeState(
        currentState : States.homeInitial,
        homeData : const [],
        recommendedDoctors : const [],
        errorMsg : ''
    );
  }

  HomeState copyWith({
    required States state,
    dynamic homeData, String? errorMessage,
    List<dynamic>? recommendedDoctors
  })
  {
    return HomeState(
      currentState: state,
      homeData: homeData?? this.homeData,
      recommendedDoctors: recommendedDoctors?? this.recommendedDoctors,
      errorMsg: errorMessage?? errorMsg,
    );
  }

  @override
  List<Object?> get props => [currentState, homeData, errorMsg, recommendedDoctors];
}