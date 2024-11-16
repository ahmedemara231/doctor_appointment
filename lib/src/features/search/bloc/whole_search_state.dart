part of 'whole_search_bloc.dart';

enum WholeSearchStates{searchInitial, searchLoading, searchSuccess, searchError}
final class SearchState extends Equatable {
  WholeSearchStates? currentState;
  List<DoctorInfo>? doctorsInfo;
  String? errorMessage;

  SearchState({
    this.currentState,
    this.doctorsInfo,
    this.errorMessage
  });

  factory SearchState.initial(){
    return SearchState(
      currentState: WholeSearchStates.searchInitial,
      doctorsInfo: const [],
      errorMessage: '',
    );
  }

  SearchState copyWith({
    WholeSearchStates? currentState,
    List<DoctorInfo>? doctorsInfo,
    String? errorMessage
}){
    return SearchState(
      currentState: currentState,
      doctorsInfo: doctorsInfo?? doctorsInfo,
      errorMessage: errorMessage?? errorMessage,
    );
  }
  @override
  List<Object?> get props => [
    currentState,
    doctorsInfo,
    errorMessage,
  ];
}
