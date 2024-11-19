import 'package:doctors_appointment/src/features/search/bloc/states.dart';
import 'package:doctors_appointment/src/features/search/repositories/search_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rxdart/rxdart.dart';
import '../../../core/data_source/remote/api_service/service/error_handling/base_remote_error_class.dart';
import '../../../core/helpers/data_types/sorting_result.dart';
import '../../home/models/doctor_data.dart';
import 'events.dart';


class WholeSearchBloc extends Bloc<SearchEvent, SearchState> {
  WholeSearchBloc(this._repo) : super(SearchState.initial()) {
    // on<SearchEvent>((event, emit) => );
    // on<SortDoctor>((event, emit) => _sortDoctors(event.result));
    on<ResetSearchState>((event, emit) => emit(state.copyWith(
      currentState: WholeSearchStates.resetResults,
      doctorsInfo: const []
    )));
    on<AddSearchHistory>((event, emit) => _addSearchHistory(event.result));
    on<SelectDoctor>((event, emit) {
      emit(state.copyWith(
          currentState: WholeSearchStates.selectDoctor,
          selectedDoctor: event.info
      ));
    });

    on<ClickNewLetter>((event, emit)async {
      emit(state.copyWith(currentState: WholeSearchStates.searchLoading));
      final result = await _search(event.pattern);
      result.when(
            (success) => emit(
            state.copyWith(
                currentState: WholeSearchStates.searchSuccess,
                doctorsInfo: success
            )),
            (error) => emit(
            state.copyWith(
                currentState: WholeSearchStates.searchError,
                errorMessage: error.message
            )),
      );},transformer: debounce(const Duration(milliseconds: 250)),
    );
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  late final SearchRepo _repo;

  Future<Result<List<DoctorInfo>, RemoteError>> _search(String pattern)async{
    final result = await _repo.search(pattern);
    return result;
  }



  // void _sortDoctors(SortingResult result,){
  //   final selectedSpeciality = result.speciality;
  //   final selectedRating = result.rating;
  //
  //   final List<DoctorInfo> doctors = List.from(state.doctorsInfo?? []);
  //   List<DoctorInfo> filteredDoctors = [];
  //
  //   switch(selectedSpeciality){
  //     case 'All':
  //       filteredDoctors = List.from(doctors);
  //
  //     default:
  //       filteredDoctors = doctors
  //           .where((doctor) => doctor.specialization.name == selectedSpeciality)
  //           .toList();
  //   }
  //
  //   emit(state.copyWith(
  //       currentState: WholeSearchStates.searchSuccess,
  //       filteredDoctors: filteredDoctors
  //   ));
  // }

  Future<void> _addSearchHistory(String result)async{
    await _repo.storeSearchResult(result);
  }
}
