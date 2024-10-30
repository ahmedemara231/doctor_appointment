import 'dart:convert';
import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:doctors_appointment/model/remote/stripe/service/stripe_constants.dart';
import 'package:multiple_result/src/result.dart';
import '../../api_service/service/Api_constants.dart';
import '../../api_service/service/api_request.dart';
import '../../api_service/service/error_handling/errors.dart';
import '../../api_service/service/request_model/request_model.dart';

class StripeConnection extends ApiService
{

  late Dio dio;

  static StripeConnection? instance;
  StripeConnection() :
        dio = Dio()..options.baseUrl = StripeConstants.baseUrl
          ..options.connectTimeout = ApiConstants.timeoutDuration
          ..options.receiveTimeout = ApiConstants.timeoutDuration;

  static StripeConnection getInstance()
  {
    return instance ??= StripeConnection();
  }


  @override
  Future<Result<Response, CustomError>> callApi({required RequestModel request})async{
    final connectivityResult = await Connectivity().checkConnectivity();

    switch(connectivityResult)
    {
      case ConnectivityResult.none:
        return Result.error(
          NetworkError(
              'Please check the internet and try again'
          ),
        );

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

          return Result.success(response);
        }on DioException catch(e)
        {
          // return Result.error(handleErrors(e));

          String prettyJson = const JsonEncoder.withIndent('  ').convert(e.response?.data);
          log(prettyJson);

          return Result.error(CustomError('Error : $e'));
        }
    }
  }
}