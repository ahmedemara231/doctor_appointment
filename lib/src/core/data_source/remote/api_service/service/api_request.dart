import 'package:dio/dio.dart';
import 'package:doctors_appointment/src/core/data_source/remote/api_service/service/request_model/request_model.dart';

abstract class ApiService {
  Future<Response> callApi({
    required RequestModel request,
  });
}