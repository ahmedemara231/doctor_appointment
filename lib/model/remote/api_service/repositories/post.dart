import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:doctors_appointment/helpers/data_types/register_inputs.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../helpers/data_types/make_appointment.dart';
import '../service/Api_constants.dart';
import '../service/Lang_methods.dart';
import '../service/api_request.dart';
import '../service/error_handling/error_checker.dart';
import '../service/request_model/request_model.dart';

class PostRepo
{
  ApiService apiService;
  PostRepo({required this.apiService});

  Future<Result<Response, ErrorInfo>> login({
    required String email,
    required String password
  }) async {
    try{
      final loginResponse = await apiService.callApi(
          request: RequestModel(
            method: Methods.POST,
            endPoint: ApiConstants.login,
            data: {'email': email, 'password': password},
          )
      );

      return Result.success(loginResponse);
    }catch(e){
      log('error occur : ${e.toString()}' );
      return Result.error(ErrorChecker.check(e));
    }
  }

  Future<Result<Response, ErrorInfo>> signUp(RegisterInputs inputs)async{
    try{
      final signUpResponse = await apiService.callApi(
          request: RequestModel(
            method: Methods.POST,
            endPoint: ApiConstants.signUp,
            data: inputs.toJson(),
          )
      );

      return Result.success(signUpResponse);
    }catch(e){
      return Result.error(ErrorChecker.check(e));
    }
  }

  Future<Result<Response, ErrorInfo>> storeAppointment({
    required MakeAppComponent model
}) async{
    try{
      final storeAppointmentResponse = await apiService.callApi(
          request: RequestModel(
            method: Methods.POST,
            endPoint: ApiConstants.makeAppointment,
            data: model.toJson()
          )
      );

      return Result.success(storeAppointmentResponse);
    }catch(e){
      return Result.error(ErrorChecker.check(e));
    }
  }

  Future<Result<void, ErrorInfo>> giveRate(int doctorId) async{
    try{
      Future.delayed(const Duration(seconds: 1)); // simulation

      return const Result.success(null);
    }catch(e){
      return Result.error(ErrorChecker.check(e));
    }
  }
}