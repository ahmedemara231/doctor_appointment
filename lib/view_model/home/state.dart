import 'package:doctors_appointment/helpers/base_extensions/string.dart';
import 'package:doctors_appointment/helpers/data_types/appointment_details.dart';
import 'package:doctors_appointment/model/remote/api_service/models/doctor_data.dart';
import 'package:equatable/equatable.dart';
import 'package:jiffy/jiffy.dart';
import 'package:intl/intl.dart';

enum States {
  homeInitial,
  homeDataLoading,
  homeDataSuccess,
  homeDataError,
  doctorsBasedOnSpecializationLoading,
  doctorsBasedOnSpecializationError,
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
}
class HomeState extends Equatable
{
  States? currentState;
  List<dynamic>? homeData;
  List<dynamic>? recommendedDoctors;
  List<dynamic>? filteredDoctors;
  String? appointmentTime;
  String? appointmentType;

  List<dynamic>? doctorsBasedOnSpecialization;

  DoctorInfo? selectedDoctor;
  List<String>? availableTimes;
  String? errorMsg;
  int? currentIndexTime;

  int? currentPage;
  String? appointmentDate;
  HomeState({
    this.currentState,
    this.homeData,
    this.recommendedDoctors,
    this.filteredDoctors,
    this.doctorsBasedOnSpecialization,
    this.selectedDoctor,
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
      homeData : const [],
      recommendedDoctors : const [],
      filteredDoctors : const [],
      doctorsBasedOnSpecialization : const [],
      selectedDoctor: null,
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
    dynamic homeData, String? errorMessage,
    List<dynamic>? recommendedDoctors,
    List<dynamic>? filteredDoctors,
    List<dynamic>? doctorsBasedOnSpecialization,
    DoctorInfo? selectedDoctor,
    List<String>? availableTimes,
    int? currentIndexTime,
    int? currentPage,
    String? appointmentDate,
    String? appointmentTime,
    String? appointmentType,
  }) {
    return HomeState(
      currentState: state,
      homeData: homeData?? this.homeData,
      recommendedDoctors: recommendedDoctors?? this.recommendedDoctors,
      filteredDoctors: filteredDoctors?? this.filteredDoctors,
      doctorsBasedOnSpecialization: doctorsBasedOnSpecialization?? this.doctorsBasedOnSpecialization,
      selectedDoctor: selectedDoctor?? this.selectedDoctor,
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
    homeData,
    errorMsg,
    recommendedDoctors,
    filteredDoctors,
    doctorsBasedOnSpecialization,
    availableTimes,
    currentIndexTime,
    currentPage
  ];
}