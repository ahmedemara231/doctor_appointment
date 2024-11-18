import 'package:dio/dio.dart';
import 'package:doctors_appointment/src/core/data_source/remote/api_service/service/Api_constants.dart';
import 'package:doctors_appointment/src/core/data_source/remote/api_service/service/Lang_methods.dart';
import 'package:doctors_appointment/src/core/data_source/remote/api_service/service/api_request.dart';
import 'package:doctors_appointment/src/core/data_source/remote/api_service/service/request_model/headers.dart';
import 'package:doctors_appointment/src/core/data_source/remote/api_service/service/request_model/request_model.dart';
import 'package:doctors_appointment/src/core/data_source/remote/firebase/realtime_database/services/error_handling/firebase_error_handler.dart';
import 'package:doctors_appointment/src/core/data_source/remote/firebase/realtime_database/services/extensions/future.dart';
import 'package:doctors_appointment/src/core/data_source/remote/firebase/realtime_database/services/interface.dart';
import 'package:doctors_appointment/src/core/data_source/remote/firebase/realtime_database/services/patients_service/data_source.dart';
import 'package:doctors_appointment/src/features/home/models/doctor_data.dart';
import 'package:multiple_result/multiple_result.dart';

class WholeSearchDataSource{
  final ApiService apiService;
  final  PatientsDataSource dataSource;
  WholeSearchDataSource({
    required this.apiService,
    required this.dataSource
});

  Future<List<DoctorInfo>> search(String doctorName)async{
    final Response result = await apiService.callApi(
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

  Future<String> storeSearchResult(String result)async{
    return dataSource.storeSearchResult(result);
  }
}