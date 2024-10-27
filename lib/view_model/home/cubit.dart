import 'dart:developer';

import 'package:doctors_appointment/helpers/data_types/sorting_result.dart';
import 'package:doctors_appointment/model/remote/api_service/repositories/get.dart';
import 'package:doctors_appointment/view_model/home/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState>
{
  HomeCubit(this.repo) : super(HomeState.initial());
  factory HomeCubit.getInstance(context) => BlocProvider.of(context);

  GetRepo repo;
  Future<void> getHomeData()async{
    emit(state.copyWith(state: States.homeDataLoading));
    final homeData = await repo.getHomeData();
    if(homeData.isSuccess()){
      emit(state.copyWith(
          state: States.homeDataSuccess,
          homeData: homeData.getOrThrow().data
      ));
      getRecommendedDoctors();
    }else{
      emit(state.copyWith(
          state: States.homeDataError,
          errorMessage: 'Failed, Please try again.'));
    }
  }

  void getRecommendedDoctors() {
    List recommendedDoctors = [];
    List filteredDoctors = [];

    for(int index = 0; index < state.homeData!.length; index++){
      for(int doctorIndex = 0; doctorIndex < state.homeData![index].allInfo.length; doctorIndex++){
        recommendedDoctors.add(state.homeData![index].allInfo[doctorIndex]);
      }
    }
    filteredDoctors = List.from(recommendedDoctors);
    emit(
        state.copyWith(
            state: States.homeDataSuccess,
            recommendedDoctors: recommendedDoctors,
            filteredDoctors: filteredDoctors
        )
    );
  }

  void sortDoctors(SortingResult result) {
    final selectedSpeciality = result.speciality;
    final selectedRating = result.rating;

    final List recommendedDoctors = List.from(state.recommendedDoctors!);
    List filteredDoctors = [];

    switch(selectedSpeciality){
      case 'All':
        filteredDoctors = List.from(recommendedDoctors);

      default:
        filteredDoctors = recommendedDoctors.where((doctor) => doctor.specialization.name == selectedSpeciality).toList();
    }

    emit(state.copyWith(
        state: States.homeDataSuccess,
        filteredDoctors: filteredDoctors
    ));
  }

  void begin(){
    List filteredDoctors = List.from(state.recommendedDoctors!);
    emit(state.copyWith(state: States.homeDataSuccess, filteredDoctors: filteredDoctors));
  }
}