import 'package:doctors_appointment/helpers/data_types/doctor_data.dart';
import 'package:doctors_appointment/model/remote/api_service/service/Api_constants.dart';
import 'package:doctors_appointment/model/remote/api_service/service/Lang_methods.dart';
import 'package:doctors_appointment/model/remote/api_service/service/request_model/headers.dart';
import 'package:doctors_appointment/model/remote/api_service/service/request_model/request_model.dart';
import 'package:multiple_result/multiple_result.dart';

import '../service/api_request.dart';

class GetRepo
{
  ApiService apiService;

  GetRepo({required this.apiService});

  Future<Result<AllDoctorsData, dynamic>> getHomeData()async{
    final homeResponse = await apiService.callApi(
        request: RequestModel(
            method: Methods.GET,
            endPoint: ApiConstants.home, 
            headers: HeadersWithToken()
        )
    );
    if(homeResponse.isSuccess()){
      AllDoctorsData data = AllDoctorsData.fromJson(homeResponse.getOrThrow().data);
      return Result.success(data);
    } else{
      return Result.error(homeResponse.tryGetError()?.message);
    }
  }
}