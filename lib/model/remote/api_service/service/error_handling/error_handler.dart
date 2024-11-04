import 'dart:developer';
import 'package:dio/dio.dart';
import 'base_remote_error_class.dart';
import 'errors.dart';

RemoteError handleDioErrors(DioException e) {
  log('code : ${e.response?.statusCode}');
  log('response error message : ${e.response?.data['message']}');

  switch(e.type) {
    case DioExceptionType.sendTimeout:
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.connectionError:
      return NetworkError(
          'Please check the internet and try again'
      );

    case DioExceptionType.badResponse:
      switch(e.response!.statusCode) {
        case 400:
          return BadRequestError(
            e.response?.data['msg']?? 'BadRequestError',
          );

        case 401:
          return UnAuthorizedError(
            e.response?.data['msg']?? 'UnAuthorizedError',
          );

        case 404:
          return NotFoundError(
            e.response?.statusMessage,
          );
        case 409:
          return ConflictError(
            e.response?.data['msg']?? 'conflictError',
          );

        case 422:
          return UnprocessableEntityError(
              e.response!.data['msg']?? 'UnProcessableEntity'
          );

        default:
          return BadResponseError(
            e.response?.data['error']['email'][0]?? 'Bad response Error',
          );
      }

    case DioExceptionType.cancel:
      return CancelError(
        e.response?.statusMessage,
      );

    case DioExceptionType.badCertificate:
      return BadCertificateError(
        e.response?.statusMessage,
      );

    case DioExceptionType.unknown:
      return UnknownError(
        e.response?.statusMessage,
      );

    default:
      return RemoteError(
        e.response?.statusMessage,
      );
  }
}