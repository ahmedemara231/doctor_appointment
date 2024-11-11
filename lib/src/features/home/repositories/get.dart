import 'package:doctors_appointment/src/core/data_source/remote/api_service/extensions/future.dart';
import 'package:doctors_appointment/src/features/home/data_source/home_data_source.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:multiple_result/multiple_result.dart';

import '../models/doctor_data.dart';
import '../../../core/data_source/remote/api_service/service/error_handling/base_remote_error_class.dart';

class HomeGetRepo {
  late final HomeDataSource _homeDataSource;
  HomeGetRepo(this._homeDataSource);

  Future<Result<AllDoctorsData, RemoteError>> getHomeData()async{
    return await _homeDataSource
        .getHomeData()
        .handleApiCalls();
  }

  Future<Result<DoctorsInSpecificField, RemoteError>> showDoctorsBasedOnSpecialization(int specializationIndex)async{
    return await _homeDataSource
        .showDoctorsBasedOnSpecialization(specializationIndex)
        .handleApiCalls();
  }

  Stream<DatabaseEvent> getMessages(int doctorId){
    return _homeDataSource.getMessages(doctorId);
  }
}