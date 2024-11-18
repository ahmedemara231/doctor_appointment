import 'package:doctors_appointment/src/features/search/repositories/search_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import '../../../core/helpers/data_types/sorting_result.dart';
import '../../home/models/doctor_data.dart';
part 'whole_search_event.dart';
part 'whole_search_state.dart';

class WholeSearchBloc extends Bloc<SearchEvent, SearchState> {
  WholeSearchBloc(this._repo) : super(SearchState.initial()) {
    on<SearchEvent>((event, emit) => _resetSearchState(emit));
    on<SortDoctor>((event, emit) => _sortDoctors(event.result, emit));
    on<ClickNewLetter>((event, emit)async =>  await _search(event.pattern, emit),
      transformer: debounce(const Duration(milliseconds: 250)),
    );
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  late final SearchRepo _repo;
  Future<void> _search(String pattern, Emitter<SearchState> emit)async{
    emit(state.copyWith(currentState: WholeSearchStates.searchLoading));
    final result = await _repo.search(pattern);
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
    );
  }

  void _sortDoctors(SortingResult result, Emitter<SearchState> emit){
    final selectedSpeciality = result.speciality;
    final selectedRating = result.rating;

    final List<DoctorInfo> doctors = List.from(state.doctorsInfo?? []);
    List<DoctorInfo> filteredDoctors = [];

    switch(selectedSpeciality){
      case 'All':
        filteredDoctors = List.from(doctors);

      default:
        filteredDoctors = doctors
            .where((doctor) => doctor.specialization.name == selectedSpeciality)
            .toList();
    }

    emit(state.copyWith(
        currentState: WholeSearchStates.searchSuccess,
        filteredDoctors: filteredDoctors
    ));
  }
  void _resetSearchState(Emitter<SearchState> emit){
    emit(state.copyWith(
      currentState: WholeSearchStates.searchSuccess,
      doctorsInfo: const []
    ));
  }
}
