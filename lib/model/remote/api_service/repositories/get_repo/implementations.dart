import '../../models/doctor_data.dart';
import '../../service/Api_constants.dart';
import '../../service/Lang_methods.dart';
import '../../service/api_request.dart';
import '../../service/request_model/headers.dart';
import '../../service/request_model/request_model.dart';

class GetImplementation{
  ApiService apiService;
  GetImplementation(this.apiService);

  Future<AllDoctorsData> getHomeData()async{
    final homeResponse = await apiService.callApi(
        request: RequestModel(
            method: Methods.GET,
            endPoint: ApiConstants.home,
            headers: HeadersWithToken()
        )
    );
    AllDoctorsData data = AllDoctorsData.fromJson(homeResponse.data);
    return data;
  }

  Future<DoctorsInSpecificField> showDoctorsBasedOnSpecialization(int specializationIndex)async{
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
      return data;
  }
}