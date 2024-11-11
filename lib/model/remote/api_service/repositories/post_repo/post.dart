import 'package:dio/dio.dart';
import 'package:doctors_appointment/helpers/data_types/register_inputs.dart';
import 'package:doctors_appointment/model/remote/api_service/extensions/future.dart';
import 'package:doctors_appointment/model/remote/api_service/repositories/post_repo/implementation.dart';
import 'package:multiple_result/multiple_result.dart';
import '../../../../../helpers/data_types/make_appointment.dart';
import '../../service/api_request.dart';
import '../../service/error_handling/base_remote_error_class.dart';


class PostRepo
{
  ApiService apiService;
  PostRepo({required this.apiService});

  Future<Result<Response, RemoteError>> login({
    required String email,
    required String password
  }) async {
    return PostRepoImpl(apiService)
        .login(email: email, password: password)
        .handleApiCalls();
  }

  Future<Result<String, RemoteError>> signUp(RegisterInputs inputs)async{
      return PostRepoImpl(apiService).signUp(inputs).handleApiCalls();
  }

  Future<Result<Response, RemoteError>> storeAppointment({
    required MakeAppComponent model
}) async{
    return PostRepoImpl(apiService)
       .storeAppointment(model: model)
       .handleApiCalls();
  }

  Future<Result<void, RemoteError>> giveRate({
    required int doctorId,
    required double rating
}) async{
    return PostRepoImpl(apiService)
       .giveRate(doctorId: doctorId, rating: rating)
       .handleApiCalls();
  }
}