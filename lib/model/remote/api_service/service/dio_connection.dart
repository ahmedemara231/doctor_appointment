import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:doctors_appointment/model/remote/api_service/service/request_model/request_model.dart';
import 'Api_constants.dart';
import 'api_request.dart';
import 'error_handling/base_remote_error_class.dart';
import 'error_handling/error_handler.dart';
import 'error_handling/errors.dart';
import 'error_handling/interceptors/bad_response.dart';
import 'error_handling/interceptors/unknown.dart';

class DioConnection implements ApiService{
  late Dio dio;
  // late Dio dioForDownload;
  DioConnection()
  {
    dio = Dio()
      ..options.baseUrl = ApiConstants.baseUrl
      ..options.connectTimeout = ApiConstants.timeoutDuration
      ..options.receiveTimeout = ApiConstants.timeoutDuration;

    List<InterceptorsWrapper> myInterceptors = [
      BadResponseInterceptor(dio),
      UnknownErrorInterceptor(),
    ];

    dio.interceptors.addAll(myInterceptors);

    // dioForDownload = Dio();
  }

  static DioConnection? dioHelper;

  static DioConnection getInstance()
  {
    return dioHelper ??= DioConnection();
  }

  final cancelRequest = CancelToken();

  void cancelApiRequest() {
    cancelRequest.cancel('canceled');
  }

  @override
  Future<Response> callApi({
    required RequestModel request
  }) async
  {
    final connectivityResult = await Connectivity().checkConnectivity();
    switch(connectivityResult)
    {
      case ConnectivityResult.none :
        RemoteError networkError = NetworkError(
            'Please check the internet and try again'
        );
        throw networkError;

      default:
        try{
          await request.prepareDataForRequest();
          final Response response = await dio.request(
            request.endPoint,
            options: Options(
                receiveDataWhenStatusError: true,
                responseType: request.responseType?? ResponseType.json,
                method: request.method,
                headers: await request.headers?.toJson()
            ),
            data: request.isFormData?
            FormData.fromMap(request.data) : request.data,
            queryParameters: request.queryParams,
            onSendProgress: request.onSendProgress,
            onReceiveProgress: request.onReceiveProgress,
            cancelToken: cancelRequest,
          );

          // String prettyJson = const JsonEncoder.withIndent('  ').convert(response.data);
          // log(prettyJson);

          return response;
        }on DioException catch(e) {
          String prettyJson = const JsonEncoder.withIndent('  ').convert(e.response?.data);
          log(prettyJson);
          throw handleDioErrors(e);
        }
    }
  }
}
