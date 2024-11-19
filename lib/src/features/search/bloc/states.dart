import 'package:equatable/equatable.dart';

import '../../home/models/doctor_data.dart';

enum WholeSearchStates{searchInitial, searchLoading, searchSuccess, selectDoctor, searchError, resetResults}
final class SearchState extends Equatable {
  WholeSearchStates? currentState;
  List<DoctorInfo>? doctorsInfo;
  DoctorInfo? selectedDoctor;
  List<DoctorInfo>? filteredDoctors;
  String? errorMessage;

  SearchState({
    this.currentState,
    this.doctorsInfo,
    this.filteredDoctors,
    this.selectedDoctor,
    this.errorMessage
  });

  factory SearchState.initial(){
    return SearchState(
      currentState: WholeSearchStates.searchInitial,
      doctorsInfo: const [],
      selectedDoctor: null,
      filteredDoctors: const [],
      errorMessage: '',
    );
  }

  SearchState copyWith({
    required WholeSearchStates currentState,
    List<DoctorInfo>? doctorsInfo,
    DoctorInfo? selectedDoctor,
    List<DoctorInfo>? filteredDoctors,
    String? errorMessage
  }){
    return SearchState(
      currentState: currentState,
      doctorsInfo: doctorsInfo?? this.doctorsInfo,
      selectedDoctor: selectedDoctor?? this.selectedDoctor,
      filteredDoctors: filteredDoctors?? this.filteredDoctors,
      errorMessage: errorMessage?? this.errorMessage,
    );
  }
  @override
  List<Object?> get props => [
    currentState,
    doctorsInfo,
    selectedDoctor,
    filteredDoctors,
    errorMessage,
  ];
}