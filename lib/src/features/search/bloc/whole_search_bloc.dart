import 'package:doctors_appointment/src/features/search/repositories/search_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import '../../home/models/doctor_data.dart';
part 'whole_search_event.dart';
part 'whole_search_state.dart';

class WholeSearchBloc extends Bloc<SearchEvent, SearchState> {
  WholeSearchBloc(this._repo) : super(SearchState.initial()) {
    on<ClickNewLetter>((event, emit)async {
      await _search(event.pattern, emit);
      }, transformer: debounce(const Duration(milliseconds: 250)),
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
}
