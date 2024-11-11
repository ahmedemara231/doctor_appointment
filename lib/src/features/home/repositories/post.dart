import 'package:dio/dio.dart';
import 'package:doctors_appointment/src/core/data_source/remote/api_service/extensions/future.dart';
import 'package:doctors_appointment/src/core/data_source/remote/firebase/realtime_database/services/error_handling/firebase_error_handler.dart';
import 'package:doctors_appointment/src/core/data_source/remote/firebase/realtime_database/services/extensions/future.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../core/data_source/remote/api_service/service/error_handling/base_remote_error_class.dart';
import '../../../core/helpers/data_types/make_appointment.dart';
import '../data_source/home_data_source.dart';

class HomePostRepo {
  late final HomeDataSource _homeDataSource;
  HomePostRepo(this._homeDataSource);

  Future<Result<Response, RemoteError>> storeAppointment({
    required MakeAppComponent model
  }) async{
    return _homeDataSource
        .storeAppointment(model: model)
        .handleApiCalls();
  }

  Future<Result<void, RemoteError>> giveRate({
    required int doctorId,
    required double rating
  }) async{
    return _homeDataSource
        .giveRate(doctorId: doctorId, rating: rating)
        .handleApiCalls();
  }

  Future<Result<String, FirebaseError>> sendMessageToDoctor({
    required String message,
    required int receiverId
  }){
    return _homeDataSource
        .sendMessageToDoctor(message: message, receiverId: receiverId)
        .handleFirebaseCalls();
  }

}


