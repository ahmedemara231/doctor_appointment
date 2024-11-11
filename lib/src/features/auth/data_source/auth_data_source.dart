import 'package:dio/dio.dart';

import '../../../core/data_source/remote/api_service/service/Api_constants.dart';
import '../../../core/data_source/remote/api_service/service/Lang_methods.dart';
import '../../../core/data_source/remote/api_service/service/api_request.dart';
import '../../../core/data_source/remote/api_service/service/request_model/request_model.dart';
import '../../../core/helpers/data_types/register_inputs.dart';

class AuthDataSource {
  late final ApiService _apiService;
  AuthDataSource(this._apiService);

  Future<Response> login({
    required String email,
    required String password
  }) async {
    final loginResponse = await _apiService.callApi(
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
    await _apiService.callApi(
        request: RequestModel(
          method: Methods.POST,
          endPoint: ApiConstants.signUp,
          data: inputs.toJson(),
        )
    );

    return 'Registered Successfully';
  }


}