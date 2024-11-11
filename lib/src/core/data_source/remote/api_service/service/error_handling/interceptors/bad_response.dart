import 'dart:developer';
import 'package:dio/dio.dart';

import '../../../../../../constants/app_constants.dart';

class BadResponseInterceptor extends InterceptorsWrapper
{
  Dio dio;
  BadResponseInterceptor(this.dio);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler)async {

    log(err.type.name);

    if(err.type == DioExceptionType.badResponse)
    {
      switch(err.response?.statusCode)
      {
        case 401:
          log(err.response!.statusMessage!);
          Constants.navigatorKey.currentState!.pushNamedAndRemoveUntil(
            '/login',
                (route) => false,
          );

        default:
          handler.reject(err);
      }
    }
    else{
      handler.next(err);
    }
  }
}