import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import '../../models/doctor_data.dart';

enum States {
  homeInitial,
  homeDataLoading,
  homeDataSuccess,
  homeDataError,
  doctorsBasedOnSpecializationLoading,
  doctorsBasedOnSpecializationSuccess,
  doctorsBasedOnSpecializationError,
  sortDoctors,
  selectDoctor,
  getAvailableTimesLoading,
  getAvailableTimesSuccess,
  getAvailableTimesError,
  changeCurrentTime,
  changeUserAppointmentDetails,
  changeAppointmentDetails,
  changeCurrentPage,
  makeAppointmentLoading,
  makeAppointmentSuccess,
  makeAppointmentError,
  giveRateLoading,
  giveRateSuccess,
  giveRateError,
  sendMessageError,
  searchSuccess
}
class HomeState extends Equatable
{
  States? currentState;
  DoctorInfo? selectedDoctor;
  List<dynamic>? homeData;
  List<DoctorInfo>? recommendedDoctors;
  List<DoctorInfo>? filteredDoctors;
  String? appointmentTime;
  String? appointmentType;
  List<DoctorInfo>? doctorsBasedOnSpecialization;
  // DoctorInfo? selectedDoctor;
  List<String>? availableTimes;
  String? errorMsg;
  int? currentIndexTime;
  int? currentPage;
  String? appointmentDate;

  HomeState({
    this.currentState,
    this.homeData,
    this.selectedDoctor,
    this.recommendedDoctors,
    this.filteredDoctors,
    this.doctorsBasedOnSpecialization,
    this.availableTimes,
    this.errorMsg,
    this.currentIndexTime,
    this.appointmentTime,
    this.appointmentType,
    this.currentPage,
    this.appointmentDate,
  });

  factory HomeState.initial(){
    return HomeState(
      currentState : States.homeInitial,
      selectedDoctor: null,
      homeData : const [],
      recommendedDoctors : const [],
      filteredDoctors : const [],
      doctorsBasedOnSpecialization : const [],
      availableTimes : const [],
      errorMsg : '',
      currentIndexTime : null,
      appointmentDate: DateFormat("d-M-yyyy").format(DateTime.now()),
      appointmentTime: null,
      appointmentType: '',
      currentPage: 0,
    );
  }

  HomeState copyWith({
    required States state,
    DoctorInfo? selectedDoctor,
    List<dynamic>? homeData, String? errorMessage,
    List<DoctorInfo>? recommendedDoctors,
    List<DoctorInfo>? filteredDoctors,
    List<DoctorInfo>? doctorsBasedOnSpecialization,
    List<String>? availableTimes,
    int? currentIndexTime,
    int? currentPage,
    String? appointmentDate,
    String? appointmentTime,
    String? appointmentType,
  }) {
    return HomeState(
      currentState: state,
      selectedDoctor: selectedDoctor?? this.selectedDoctor,
      homeData: homeData?? this.homeData,
      recommendedDoctors: recommendedDoctors?? this.recommendedDoctors,
      filteredDoctors: filteredDoctors?? this.filteredDoctors,
      doctorsBasedOnSpecialization: doctorsBasedOnSpecialization?? this.doctorsBasedOnSpecialization,
      availableTimes: availableTimes?? this.availableTimes,
      errorMsg: errorMessage?? errorMsg,
      appointmentDate: appointmentDate?? this.appointmentDate,
      appointmentTime: appointmentTime?? this.appointmentTime,
      appointmentType: appointmentType?? this.appointmentType,
      currentIndexTime: currentIndexTime,
      currentPage: currentPage?? this.currentPage
    );
  }

  @override
  List<Object?> get props => [
    currentState,
    selectedDoctor,
    homeData,
    errorMsg,
    recommendedDoctors,
    filteredDoctors,
    doctorsBasedOnSpecialization,
    availableTimes,
    currentIndexTime,
    appointmentTime,
    appointmentType,
    appointmentDate,
    currentPage
  ];
}