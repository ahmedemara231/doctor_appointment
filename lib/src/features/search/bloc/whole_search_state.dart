part of 'whole_search_bloc.dart';

enum WholeSearchStates{searchInitial, searchLoading, searchSuccess, searchError}
final class SearchState extends Equatable {
  WholeSearchStates? currentState;
  List<DoctorInfo>? doctorsInfo;
  List<DoctorInfo>? filteredDoctors;
  String? errorMessage;

  SearchState({
    this.currentState,
    this.doctorsInfo,
    this.filteredDoctors,
    this.errorMessage
  });

  factory SearchState.initial(){
    return SearchState(
      currentState: WholeSearchStates.searchInitial,
      doctorsInfo: const [],
      filteredDoctors: const [],
      errorMessage: '',
    );
  }

  SearchState copyWith({
    WholeSearchStates? currentState,
    List<DoctorInfo>? doctorsInfo,
    List<DoctorInfo>? filteredDoctors,
    String? errorMessage
}){
    return SearchState(
      currentState: currentState,
      doctorsInfo: doctorsInfo?? doctorsInfo,
      filteredDoctors: filteredDoctors?? filteredDoctors,
      errorMessage: errorMessage?? errorMessage,
    );
  }
  @override
  List<Object?> get props => [
    currentState,
    doctorsInfo,
    filteredDoctors,
    errorMessage,
  ];
}
