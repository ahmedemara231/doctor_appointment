import 'dart:developer';
import 'package:doctors_appointment/helpers/data_types/appointment_details.dart';
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

  Future<void> showDoctorsBasedOnSpeciality(int specializationIndex)async{
    emit(state.copyWith(state: States.doctorsBasedOnSpecializationLoading));
    final result = await repo.showDoctorsBasedOnSpecialization(specializationIndex);
    if(result.isSuccess()){
      log(result.getOrThrow().toString());
      emit(state.copyWith(
          state: States.homeDataSuccess,
          doctorsBasedOnSpecialization: result.getOrThrow().allInfo
      ));
    }else{
      emit(state.copyWith(
          state: States.doctorsBasedOnSpecializationError,
        errorMessage: 'Failed, Please try again.'
      ));
    }
  }

  void getAvailableTimes({DateTime? time, int? doctorId}) async{
    List<String> availableTimes = [];
    emit(state.copyWith(state: States.getAvailableTimesLoading));

    await Future.delayed(const Duration(seconds: 3)).whenComplete(() {
      availableTimes = [
        '8:00 AM',
        '9:30 AM'
      ];
    });

    emit(state.copyWith(
        state: States.getAvailableTimesSuccess,
        availableTimes: availableTimes
    ));
  }

  void selectTime(int index){
    emit(state.copyWith(
        state: States.changeCurrentTime,
        currentIndexTime: index
    ));
  }


  void changeAppointmentDate(String appointmentDate){
    emit(
        state.copyWith(
            state: States.changeAppointmentDetails,
            appointmentDate: appointmentDate
        )
    );
  }

  void changeAppointmentTime(String appointmentTime){
    emit(
        state.copyWith(
            state: States.changeAppointmentDetails,
            appointmentTime: appointmentTime ,
        )
    );
  }

  void changeAppointmentType(String appointmentType){
    emit(
        state.copyWith(
          state: States.changeAppointmentDetails,
          appointmentType: appointmentType
        )
    );
  }

  void changeCurrentPage(int page){
    if(page <= 2){
      emit(
          state.copyWith(
              state: States.changeCurrentPage,
              currentPage: page
          )
      );
    }
  }
}