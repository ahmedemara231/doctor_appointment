import 'package:dio/dio.dart';
import 'package:doctors_appointment/src/core/data_source/remote/api_service/service/Api_constants.dart';
import 'package:doctors_appointment/src/core/data_source/remote/api_service/service/Lang_methods.dart';
import 'package:doctors_appointment/src/core/data_source/remote/api_service/service/api_request.dart';
import 'package:doctors_appointment/src/core/data_source/remote/api_service/service/request_model/headers.dart';
import 'package:doctors_appointment/src/core/data_source/remote/api_service/service/request_model/request_model.dart';
import 'package:doctors_appointment/src/features/home/models/doctor_data.dart';

class WholeSearchDataSource{
  final ApiService _apiService;
  WholeSearchDataSource(this._apiService);

  Future<List<DoctorInfo>> search(String doctorName)async{
    final Response result = await _apiService.callApi(
        request: RequestModel(
            method: Methods.GET,
            endPoint: ApiConstants.doctorSearch,
            queryParams: {'name' : doctorName},
            headers: HeadersWithToken()
        )
    );

    final List<DoctorInfo> info = (result.data['data'] as List<dynamic>)
        .map((e) =>
        DoctorInfo.fromJson(e))
        .toList();
    return info;
  }
}