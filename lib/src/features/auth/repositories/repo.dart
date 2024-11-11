import 'package:dio/dio.dart';
import 'package:doctors_appointment/src/core/data_source/remote/api_service/extensions/future.dart';
import 'package:doctors_appointment/src/features/auth/data_source/auth_data_source.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../core/data_source/remote/api_service/service/error_handling/base_remote_error_class.dart';
import '../../../core/helpers/data_types/register_inputs.dart';

class AuthRepo{
  late final AuthDataSource _authDataSource;
  AuthRepo(this._authDataSource);

  Future<Result<Response, RemoteError>> login({
    required String email,
    required String password
  }) async {
    return _authDataSource
        .login(email: email, password: password)
        .handleApiCalls();
  }

  Future<Result<String, RemoteError>> signUp(RegisterInputs inputs)async{
    return _authDataSource.signUp(inputs).handleApiCalls();
  }
}