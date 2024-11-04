import 'package:doctors_appointment/model/remote/api_service/models/doctor_data.dart';
import 'package:doctors_appointment/model/remote/api_service/service/Api_constants.dart';
import 'package:doctors_appointment/model/remote/api_service/service/Lang_methods.dart';
import 'package:doctors_appointment/model/remote/api_service/service/error_handling/error_checker.dart';
import 'package:doctors_appointment/model/remote/api_service/service/request_model/headers.dart';
import 'package:doctors_appointment/model/remote/api_service/service/request_model/request_model.dart';
import 'package:multiple_result/multiple_result.dart';

import '../service/api_request.dart';

class GetRepo {
  ApiService apiService;
  GetRepo({required this.apiService});

  Future<Result<AllDoctorsData, ErrorInfo>> getHomeData()async{
    try{
      final homeResponse = await apiService.callApi(
          request: RequestModel(
              method: Methods.GET,
              endPoint: ApiConstants.home,
              headers: HeadersWithToken()
          )
      );

      AllDoctorsData data = AllDoctorsData.fromJson(homeResponse.data);
      return Result.success(data);
    }catch(e){
      return Result.error(ErrorChecker.check(e));
    }
  }

  Future<Result<DoctorsInSpecificField, ErrorInfo>> showDoctorsBasedOnSpecialization(int specializationIndex)async{
    try{
      final response = await apiService.callApi(
          request: RequestModel(
              method: Methods.GET,
              endPoint: ApiConstants.doctorsBasedOnSpecialization+specializationIndex.toString(),
              headers: HeadersWithToken()
          )
      );
      DoctorsInSpecificField data = DoctorsInSpecificField.fromJson(
          response.data['data']
      );
      return Result.success(data);
    }catch(e){
      return Result.error(ErrorChecker.check(e));
    }
  }
}