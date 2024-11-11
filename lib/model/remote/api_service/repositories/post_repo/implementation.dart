import 'package:dio/dio.dart';
import '../../../../../helpers/data_types/make_appointment.dart';
import '../../../../../helpers/data_types/register_inputs.dart';
import '../../service/Api_constants.dart';
import '../../service/Lang_methods.dart';
import '../../service/api_request.dart';
import '../../service/request_model/headers.dart';
import '../../service/request_model/request_model.dart';

class PostRepoImpl {
  ApiService apiService;
  PostRepoImpl(this.apiService);

  Future<Response> login({
    required String email,
    required String password
  }) async {
      final loginResponse = await apiService.callApi(
          request: RequestModel(
            method: Methods.POST,
            endPoint: ApiConstants.login,
            data: {'email': email, 'password': password},
          )
      );

      final msg = loginResponse;
      return msg;
  }

  Future<String> signUp(RegisterInputs inputs)async{
      final signUpResponse = await apiService.callApi(
          request: RequestModel(
            method: Methods.POST,
            endPoint: ApiConstants.signUp,
            data: inputs.toJson(),
          )
      );

      return 'Registered Successfully';
  }

  Future<Response> storeAppointment({
    required MakeAppComponent model
  }) async{
      final storeAppointmentResponse = await apiService.callApi(
          request: RequestModel(
              method: Methods.POST,
              endPoint: ApiConstants.makeAppointment,
              data: model.toJson(),
              headers: HeadersWithToken()
          )
      );

      return storeAppointmentResponse;
  }

  Future<String> giveRate({
    required int doctorId,
    required double rating
  }) async{
      Future.delayed(const Duration(seconds: 1)); // simulation
      return 'Thank you for rating!';
  }
}