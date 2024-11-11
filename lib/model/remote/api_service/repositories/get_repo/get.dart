import 'package:doctors_appointment/model/remote/api_service/extensions/future.dart';
import 'package:doctors_appointment/model/remote/api_service/models/doctor_data.dart';
import 'package:doctors_appointment/model/remote/api_service/repositories/get_repo/implementations.dart';
import 'package:doctors_appointment/model/remote/api_service/service/error_handling/base_remote_error_class.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../service/api_request.dart';

class GetRepoImpl {
  ApiService apiService;
  GetRepoImpl({required this.apiService});

  Future<Result<AllDoctorsData, RemoteError>> getHomeData()async{
      return await GetImplementation(apiService)
          .getHomeData()
          .handleApiCalls();
  }

  Future<Result<DoctorsInSpecificField, RemoteError>> showDoctorsBasedOnSpecialization(int specializationIndex)async{
    return await GetImplementation(apiService)
        .showDoctorsBasedOnSpecialization(specializationIndex)
        .handleApiCalls();
    }
  }