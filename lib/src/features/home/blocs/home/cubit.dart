import 'dart:developer';
import 'package:doctors_appointment/src/features/home/blocs/home/state.dart';
import 'package:doctors_appointment/src/features/home/repositories/get.dart';
import 'package:doctors_appointment/src/features/home/repositories/post.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/data_types/make_appointment.dart';
import '../../../../core/helpers/data_types/sorting_result.dart';
import '../../models/doctor_data.dart';

class HomeCubit extends Cubit<HomeState>
{
  HomeCubit({required this.getRepo, required this.postRepo}) : super(HomeState.initial());
  factory HomeCubit.getInstance(context) => BlocProvider.of(context);

  HomeGetRepo getRepo;
  HomePostRepo postRepo;
  Future<void> getHomeData()async{
    emit(state.copyWith(state: States.homeDataLoading));
    final homeData = await getRepo.getHomeData();
    if(homeData.isSuccess()){
      emit(state.copyWith(
          state: States.homeDataSuccess,
          homeData: homeData.getOrThrow().data
      ));
      getRecommendedDoctors();
    }else{
      emit(state.copyWith(
          state: States.homeDataError,
          errorMessage: homeData.tryGetError()?.message));
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
    final result = await getRepo.showDoctorsBasedOnSpecialization(specializationIndex);
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

  void selectDoctor({required DoctorInfo? selectedDoctor}){
    emit(state.copyWith(
        state: States.selectDoctor,
        selectedDoctor: selectedDoctor
    ));
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

  Future<void> makeAppointment()async{
    emit(state.copyWith(state: States.makeAppointmentLoading));
    final response = await postRepo.storeAppointment(
        model: MakeAppComponent(
          appointmentDate: state.appointmentDate!,
          appointmentTime: state.appointmentTime!,
          doctorId: state.selectedDoctor!.id.toString()
        )
    );
    response.when(
            (success) => emit(state.copyWith(state: States.makeAppointmentSuccess)),
            (error) => emit(state.copyWith(state: States.makeAppointmentError))
    );
  }

  Future<void> giveRate(double rating)async{
    emit(state.copyWith(state: States.giveRateLoading));
    final result = await postRepo.giveRate(
      doctorId: state.selectedDoctor!.id,
      rating: rating
    );
    result.when(
            (success) => emit(state.copyWith(state: States.giveRateSuccess)),
            (error) => emit(state.copyWith(state: States.giveRateError)),
    );
  }
}