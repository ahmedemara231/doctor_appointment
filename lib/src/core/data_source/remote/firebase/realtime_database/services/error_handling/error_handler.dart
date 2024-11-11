import 'package:firebase_core/firebase_core.dart';
import 'errors.dart';
import 'firebase_error_handler.dart';

class DatabaseErrorCode {
  static const String unavailable = 'No internet connection, please try again later';
  static const String permissionDenied = 'You do not have permission to perform this operation';
  static const String defaultError = 'can\'t make changes, please try again later';
}

class RealTimeErrorHandler {
  static FirebaseError handle(FirebaseException e){
    String? errorMsg;
    switch (e.code) {
      case 'database/permission-denied':
        errorMsg = DatabaseErrorCode.permissionDenied;
        return PermissionDeniedError(errorMsg);

      case 'database/network-error':
        errorMsg = DatabaseErrorCode.unavailable;
        return UnavailableError(errorMsg);

      case 'database/timeout':
        errorMsg = DatabaseErrorCode.unavailable;
        return UnavailableError(errorMsg);

      default:
        errorMsg = DatabaseErrorCode.defaultError;
        return DefaultError(errorMsg);
    }
  }
}