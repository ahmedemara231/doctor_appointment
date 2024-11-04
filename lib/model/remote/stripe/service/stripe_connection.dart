import 'dart:convert';
import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:doctors_appointment/model/remote/stripe/service/error_handling/errors.dart';
import 'package:doctors_appointment/model/remote/stripe/service/stripe_constants.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import '../../api_service/service/Api_constants.dart';
import '../../api_service/service/api_request.dart';
import '../../api_service/service/error_handling/base_remote_error_class.dart';
import '../../api_service/service/error_handling/errors.dart';
import '../../api_service/service/request_model/request_model.dart';

class StripeConnection extends ApiService {
  late Dio dio;

  static StripeConnection? instance;
  StripeConnection() :
        dio = Dio()..options.baseUrl = StripeConstants.baseUrl
          ..options.connectTimeout = ApiConstants.timeoutDuration
          ..options.receiveTimeout = ApiConstants.timeoutDuration;

  static StripeConnection getInstance() {
    return instance ??= StripeConnection();
  }


  @override
  Future<Response> callApi({required RequestModel request})async{
    final connectivityResult = await Connectivity().checkConnectivity();

    switch(connectivityResult)
    {
      case ConnectivityResult.none:
        throw NetworkError('Please check the internet and try again');

      default:
        try{
          final Response response = await dio.request(
            request.endPoint,
            options: Options(
                receiveDataWhenStatusError: true,
                responseType: request.responseType?? ResponseType.json,
                method: request.method,
                headers: await request.headers!.toJson()
            ),
            data: request.isFormData?
            FormData.fromMap(request.data) : request.data,
            queryParameters: request.queryParams,
            onSendProgress: request.onSendProgress,
            onReceiveProgress: request.onReceiveProgress,
          );

          return response;
        }on DioException catch(e) {
          String prettyJson = const JsonEncoder.withIndent('  ').convert(e.response?.data);
          log(prettyJson);

          throw RemoteError('Error : $e');
        }on StripeException catch(e) {
          String prettyJson = const JsonEncoder.withIndent('  ').convert(e.toJson());
          log(prettyJson);

          throw GeneralStripeError(e.error.message);
        }
    }
  }
}