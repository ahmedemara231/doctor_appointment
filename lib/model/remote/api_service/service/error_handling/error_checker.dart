import 'package:doctors_appointment/model/remote/api_service/service/error_handling/base_remote_error_class.dart';
import 'package:doctors_appointment/model/remote/api_service/service/error_handling/errors.dart';

class ErrorInfo{
  final String message;

  ErrorInfo(this.message);
}

class ErrorChecker{
  static ErrorInfo check(dynamic e){
    switch(e){
      case RemoteError e :
        switch(e) {
          case NetworkError e:
            return ErrorInfo(e.message!);

          case BadResponseError e:
            return ErrorInfo(e.message!);

          case BadRequestError e:
            return ErrorInfo(e.message!);

          case UnAuthorizedError e:
            return ErrorInfo(e.message!);

          case NotFoundError e:
            return ErrorInfo(e.message!);

          case ConflictError e:
            return ErrorInfo(e.message!);

          case UnprocessableEntityError e:
            return ErrorInfo(e.message!);

          case BadCertificateError e:
            return ErrorInfo(e.message!);

          case CancelError e:
            return ErrorInfo(e.message!);

          case UnknownError e:
            return ErrorInfo(e.message!);

          default:
            return ErrorInfo('Error');
        }

      default:
        return ErrorInfo('Error');
    }
  }
}

