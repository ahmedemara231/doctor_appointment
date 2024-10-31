import 'package:doctors_appointment/helpers/data_types/appointment_details.dart';
import 'package:equatable/equatable.dart';

enum States {
  homeInitial,
  homeDataLoading,
  homeDataSuccess,
  homeDataError,
  doctorsBasedOnSpecializationLoading,
  doctorsBasedOnSpecializationError,
  getAvailableTimesLoading,
  getAvailableTimesSuccess,
  getAvailableTimesError,
  changeCurrentTime,
  changeUserAppointmentDetails, changeAppointmentDetails,
}
class HomeState extends Equatable
{
  States? currentState;
  List<dynamic>? homeData;
  List<dynamic>? recommendedDoctors;
  List<dynamic>? filteredDoctors;
  UserAppointmentDetails? details;

  List<dynamic>? doctorsBasedOnSpecialization;
  List<String>? availableTimes;
  String? errorMsg;
  int? currentIndexTime;
  HomeState({
    this.currentState,
    this.homeData,
    this.recommendedDoctors,
    this.filteredDoctors,
    this.doctorsBasedOnSpecialization,
    this.availableTimes,
    this.errorMsg,
    this.currentIndexTime,
    this.details
  });

  factory HomeState.initial(){
    return HomeState(
        currentState : States.homeInitial,
        homeData : const [],
        recommendedDoctors : const [],
        filteredDoctors : const [],
        doctorsBasedOnSpecialization : const [],
        availableTimes : const [],
        errorMsg : '',
        currentIndexTime : null,
        details: null
    );
  }

  HomeState copyWith({
    required States state,
    dynamic homeData, String? errorMessage,
    List<dynamic>? recommendedDoctors,
    List<dynamic>? filteredDoctors,
    List<dynamic>? doctorsBasedOnSpecialization,
    List<String>? availableTimes,
    int? currentIndexTime,
    UserAppointmentDetails? details
  })
  {
    return HomeState(
      currentState: state,
      homeData: homeData?? this.homeData,
      recommendedDoctors: recommendedDoctors?? this.recommendedDoctors,
      filteredDoctors: filteredDoctors?? this.filteredDoctors,
      doctorsBasedOnSpecialization: doctorsBasedOnSpecialization?? this.doctorsBasedOnSpecialization,
      availableTimes: availableTimes?? this.availableTimes,
      errorMsg: errorMessage?? errorMsg,
      details: details?? this.details,
      currentIndexTime: currentIndexTime
    );
  }

  @override
  List<Object?> get props => [
    currentState,
    homeData,
    errorMsg,
    recommendedDoctors,
    filteredDoctors,
    doctorsBasedOnSpecialization,
    availableTimes,
    currentIndexTime,
  ];
}