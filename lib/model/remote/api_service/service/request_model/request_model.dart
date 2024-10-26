import 'dart:io';
import 'package:dio/dio.dart';
import 'package:doctors_appointment/model/remote/api_service/extensions/file.dart';
import 'headers.dart';

class RequestModel
{
  String method;
  String endPoint;
  RequestHeaders? headers;
  dynamic data;
  bool isFormData;
  Map<String,dynamic>? queryParams;
  ResponseType? responseType;
  void Function(int count, int total)? onSendProgress;
  void Function(int count, int total)? onReceiveProgress;

  RequestModel({
    required this.method,
    required this.endPoint,
    this.headers,
    this.data,
    this.queryParams,
    this.responseType,
    this.onSendProgress,
    this.onReceiveProgress,
    this.isFormData = false,
  });



  Future<void> prepareDataForRequest()async
  {
    if(data != null)
    {
      (data as Map<String, dynamic>).forEach((key, value)async {
        if(value is File)
        {
          isFormData = true;
          await value.toMultiPartFile();
        }
      });
    }
  }
}

