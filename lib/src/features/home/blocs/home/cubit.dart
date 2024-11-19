import 'package:doctors_appointment/src/features/home/blocs/home/sorting/interface.dart';
import 'package:doctors_appointment/src/features/home/blocs/home/state.dart';
import 'package:doctors_appointment/src/features/home/repositories/get.dart';
import 'package:doctors_appointment/src/features/home/repositories/post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/data_types/make_appointment.dart';
import '../../../../core/helpers/data_types/sorting_result.dart';
import '../../models/doctor_data.dart';

class HomeCubit extends Cubit<HomeState>
{
  HomeCubit({required this.getRepo, required this.postRepo}) : super(HomeState.initial());

  HomeGetRepo getRepo;
  HomePostRepo postRepo;
  Future<void> getHomeData()async{
    emit(state.copyWith(state: States.homeDataLoading));
    final homeData = await getRepo.getHomeData();
    homeData.when(
            (success) {
              emit(state.copyWith(
                  state: States.homeDataSuccess,
                  homeData: success.data,
              ));
            },
            (error) => emit(state.copyWith(
                state: States.homeDataError,
                errorMessage: homeData.tryGetError()?.message))
    );
  }

  void getRecommendedDoctors() {
    List<DoctorInfo> recommendedDoctors = [];
    List<DoctorInfo> filteredDoctors = [];

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
            filteredDoctors: filteredDoctors,
        )
    );
  }

  List<DoctorInfo> select(bool isByRecommended){
      switch(isByRecommended){
        case true:
          return state.recommendedDoctors!;
        case false:
          return state.doctorsBasedOnSpecialization!;
      }
  }
  void search({
    required String pattern,
    required bool isByRecommended,
}){
    final List<DoctorInfo> fullList = List.from( select(isByRecommended));
    List<DoctorInfo> result = [];
    switch(pattern){
      case '':
        result = List.from(fullList);

      default:
        result = fullList
            .where((element) => element.name.toLowerCase()
            .contains(pattern))
            .toList();
    }
    emit(state.copyWith(
        state: States.searchSuccess,
        filteredDoctors: result
    ));
  }

  void sortDoctors({
    required SortingInterface place,
    required SortingResult result,
    required List<DoctorInfo> preSortedDoctorsList
}){
    final List<DoctorInfo> filteredDoctors = place.execute(
        result: result,
        preSortedDoctorsList: preSortedDoctorsList
    );

    emit(state.copyWith(
        state: States.sortDoctors,
        filteredDoctors: filteredDoctors
    ));
  }

  Future<void> showDoctorsBasedOnSpeciality(int specializationIndex)async{
    emit(state.copyWith(state: States.doctorsBasedOnSpecializationLoading));
    final result = await getRepo.showDoctorsBasedOnSpecialization(specializationIndex);
    result.when(
            (success) => emit(state.copyWith(
                state: States.doctorsBasedOnSpecializationSuccess,
                doctorsBasedOnSpecialization: success.allInfo,
                filteredDoctors: success.allInfo
            )),
            (error) => emit(state.copyWith(
                state: States.doctorsBasedOnSpecializationError,
                errorMessage: 'Failed, Please try again.'
            ))
    );
  }

  void selectDoctor(DoctorInfo info){
    emit(state.copyWith(
        state: States.selectDoctor,
        selectedDoctor: info
    ));
  }

  late PageController makeDoctorAppointmentController;

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

  Future<void> makeAppointment(int doctorId)async{
    emit(state.copyWith(state: States.makeAppointmentLoading));
    final response = await postRepo.storeAppointment(
        model: MakeAppComponent(
          appointmentDate: state.appointmentDate!,
          appointmentTime: state.appointmentTime!,
          doctorId: doctorId.toString()
        )
    );
    response.when(
            (success) => emit(state.copyWith(state: States.makeAppointmentSuccess)),
            (error) => emit(state.copyWith(state: States.makeAppointmentError))
    );
  }

  Future<void> giveRate({required double rating, required int doctorId})async{
    emit(state.copyWith(state: States.giveRateLoading));
    final result = await postRepo.giveRate(
      doctorId: doctorId,
      rating: rating
    );
    result.when(
            (success) => emit(state.copyWith(state: States.giveRateSuccess)),
            (error) => emit(state.copyWith(state: States.giveRateError)),
    );
  }
}